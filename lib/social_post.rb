# Class that represents a social post resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the social post objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the social post resource. You can consider this an initial approach
# for an object oriented solution that you can expand according to your needs.

require_relative 'resource'
require_relative 'message'

module VerticalResponse
  module API
    class SocialPost < Resource
      class << self
        # Base URI for the Email resource
        def base_uri(*args)
          @base_uri ||= File.join(super.to_s, 'messages', 'social_posts')
        end

        # Overwrite from parent class since it's a special type of
        # resource name (with messages at the beginning)
        def resource_name
          'messages/social_posts'
        end

        # The SocialPost API does not support the 'all' method on its own for now.
        # To get all social posts we need to do it through the Message API
        def all(options = {})
          Message.all(options.merge({ :message_type => MESSAGE_TYPE }))
        end
      end

      MESSAGE_TYPE = 'social_post'
    end
  end
end
