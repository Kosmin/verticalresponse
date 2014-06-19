# Class that represents the response you can get from calling any action
# of the VerticalResponse API.

require_relative 'error'

module VerticalResponse
  module API
    class Response
      attr_reader :url, :items, :attributes, :links, :success, :error, :raw_response

      def initialize(response)
        @url =          response['url']
        @items =        response['items']
        @attributes =   response['attributes']
        @links =        response['links']
        @success =      response['success']
        @error =        response['error']
        @raw_response = response

        handle_error unless success?
      end

      # Iterate through the collection of items and yield a new Response object
      # for each one of them
      def handle_collection
        items.map do |item|
          yield(Response.new(item))
        end
      end

      # Determines if the response is a successful one or not
      def success?
        !error
      end

      # Handles the case of an error response
      def handle_error
        api_error = Error.new(error['message'] || error.inspect)
        # Keep track of the original error code and response object
        # for clients to have access to them if they rescue the exception
        api_error.code = error['code']
        api_error.api_response = self

        raise api_error
      end
    end
  end
end
