# Class that represents a contact resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the contact objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the contact resource. You can consider this an initial
# approach for an object oriented solution that you can expand according to
# your needs.

require_relative 'message'

module VerticalResponse
  module API
    class Contact < Resource
      class << self
        def resource_uri_suffix
          ['contacts']
        end

        def fields(options = {})
          Response.new(get(resource_uri('fields'), build_query_params(options)), options[:access_token])
        end

        def find_by_email(options = {})
          validate_supported_method!(:find)
          response = Response.new(get(resource_uri,build_query_params(options)), options[:access_token])

          object_collection(response, options[:access_token])
        end
      end

      def initialize(*args)
        super
        @list_class = self.class.class_for_resource(List, id)
        @message_class = self.class.class_for_resource(Message, id)
      end

      # Returns all the lists this contact belongs to
      def lists(options = {})
        options.merge!(access_token: @access_token)
        @list_class.all(options)
      end

      # Returns all the messages targetted to the current contact
      def messages(options = {})
        options.merge!(access_token: @access_token)
        @message_class.all(options)
      end
    end

  end
end
