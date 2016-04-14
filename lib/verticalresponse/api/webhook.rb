# Class that represents a webhook resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the contact objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the contact resource. You can consider this an initial
# approach for an object oriented solution that you can expand according to
# your needs.
require_relative 'client'

module VerticalResponse
  module API
    class Webhook < Resource

      class << self
        def resource_uri_suffix
          ['hooks']
        end

        def initialize(*args)
          super
        end

        def list_hooks(options = {})
          auth = "Bearer " + options[:access_token]
          Response.new(HTTParty.get(resource_uri, :headers => { "Authorization" => auth}))
        end

        def create_hook(options = {})
          params = build_params(options.except(:access_token).to_json, options.slice(:access_token))
          params.merge!(headers: {"Content-Type"=>"application/json"})
          Response.new(post(resource_uri, params), options[:access_token])
        end

        def delete_hook(options = {})
          auth = "Bearer " + options[:access_token]
          url = "#{resource_uri}/#{options[:id]}"
          Response.new(HTTParty.delete(url, :headers => { "Authorization" => auth}))
        end
      end
    end
  end
end
