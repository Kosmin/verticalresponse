# Class that represents a message resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the message objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the message resource. You can consider this an initial approach
# for an object oriented solution that you can expand according to your needs.

require_relative 'email'
require_relative 'social_post'

module VerticalResponse
  module API
    class Message < Resource
      class << self
        # Base URI for the Message resource
        def base_uri(*args)
          @base_uri ||= File.join(super.to_s, 'messages')
        end

        # Overwritting this method from the parent class since we want to
        # return object instances depending on the message type
        def object_collection(response)
          response.handle_collection do |response_item|
            message_class = self
            if response_item.attributes && response_item.attributes.has_key?('message_type')
              type = response_item.attributes['message_type'].downcase.gsub(' ', '_')
              if type == Email::MESSAGE_TYPE
                message_class = Email
              elsif type == SocialPost::MESSAGE_TYPE
                message_class = SocialPost
              end
            end
            message_class.new(response_item)
          end
        end
      end

      # Remove methods that are not supported by the Message API.
      # Message only supports the 'all' method for now
      exclude_methods :create, :find, :update, :delete, :stats
    end
  end
end
