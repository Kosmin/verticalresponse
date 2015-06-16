# Class that represents a user account info resource from the VerticalResponse API.
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
    class User < Resource

      class << self
        def resource_uri_suffix
          ['users']
        end

        def initialize(*args)
          super
        end

        def info(options = {})
          url = "#{resource_uri}/#{options['uid']}"
          params = build_query_params(options.slice(:access_token))
          Response.new(get(url, params), options[:access_token])
        end
      end
    end
  end
end
