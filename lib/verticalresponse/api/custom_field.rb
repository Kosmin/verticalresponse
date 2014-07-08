# Class that represents a custom field resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the custom field objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the custom field resource. You can consider this an initial approach
# for an object oriented solution that you can expand according to your needs.

require_relative 'resource'

module VerticalResponse
  module API
    class CustomField < Resource
      class << self
        def resource_uri_suffix
          ['custom_fields']
        end

        def id_regexp
          /[a-z0-9 _%]{1,255}/i
        end

        def id_attribute_name
          'name'
        end
      end
    end
  end
end
