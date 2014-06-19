# This is the base class for the VerticalResponse API.
# It contains common functionality that other classes can use to connect to the
# API and make REST calls to it.

require 'httparty'
require_relative 'response'

module VerticalResponse
  module API
    class Client
      include HTTParty

      format :json

      class << self
        def config
          VerticalResponse::CONFIG
        end

        # Assign the headers required by our partner Mashery
        def assign_headers(headers_info = {})
          access_token = headers_info[:access_token]
          add_default_query_param(:access_token, access_token)
        end

        def embed_resource(resource, resource_id = nil)
          @embed_resource = resource
          @embed_resource_id = resource_id if resource_id
        end

        # Returns the base URI of the VerticalResponse API.
        # It builds the URI based on the values from the API configuration file.
        # 'host' must be defined (unless host_uri is specified as an input param)
        # otherwise the method will raise an exception.
        def base_uri(host_uri = nil)
          uri = host_uri
          unless uri
            unless VerticalResponse::CONFIG[:host]
              raise ConfigurationError, 'Configuration option "host" must be defined.'
            end

            uri = URI::Generic.new(
              VerticalResponse::CONFIG[:protocol] || 'http', # protocol scheme
              nil,                          # user info
              VerticalResponse::CONFIG[:host],               # host
              VerticalResponse::CONFIG[:port],               # port
              nil,                          # registry of naming authorities
              nil,                          # path on server
              nil,                          # opaque part
              nil,                          # query data
              nil                           # fragment (part of URI after '#' sign)
            )
          end

          paths = ['api', 'v1']
          paths << @embed_resource.to_s if @embed_resource
          paths << @embed_resource_id.to_s if @embed_resource_id
          URI.join(uri, File.join(*paths))
        end

        def build_params(params, query_params = {})
          request_params = {}
          request_params[:body] = params if params
          # Add whatever query params we have as well
          request_params.merge(build_query_params(query_params))
        end

        def build_query_params(params = {})
          query_params = {}
          # Include the default query params
          params = params.merge(default_query_params)
          query_params[:query] = params if params.any?
          query_params
        end

        def default_query_params
          @@default_query_params ||= {}
        end

        def add_default_query_param(param, value)
          @@default_query_params ||= {}
          @@default_query_params[param] = value
        end

        # Resource URI for the current class
        def resource_uri(*additional_paths)
          uri = base_uri
          if additional_paths.any?
            # Convert all additional paths to string
            additional_paths = additional_paths.map do |path|
              # We need to escape each path in case it contains caracters that
              # are not appropriate to use as part of an URL.
              # Unescape and then escape again in case the path is already escaped
              URI::escape(URI::unescape(path.to_s))
            end
            uri = File.join(uri, *additional_paths)
          end
          uri
        end
      end

      # Set default headers for OAuth authentication
      assign_headers

      attr_accessor :response

      def initialize(response)
        self.response = response
      end
    end
  end
end
