# Class that represents an email resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the email objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the email resource. You can consider this an initial approach
# for an object oriented solution that you can expand according to your needs.

require_relative 'resource'
require_relative 'list'

module VerticalResponse
  module API
    class Email < Resource
      class << self
        def resource_uri_suffix
          ['messages', 'emails']
        end

        # Overwrite from parent class since it's a special type of
        # resource name (with messages at the beginning)
        def resource_name
          'messages/emails'
        end

        # The Email API does not support the 'all' method on its own for now.
        # To get all emails we need to do it through the Message API
        def all(options = {})
          Message.all(options.merge({ :message_type => MESSAGE_TYPE }))
        end
      end

      MESSAGE_TYPE = 'email'

      def initialize(*args)
        super
        @list_class = self.class.class_for_resource(List, id)
      end

      # Returns all the lists this email is targeted to
      def lists(options = {})
        @list_class.all(options)
      end

      def test_launch(params = {})
        Response.new self.class.post(
          self.class.resource_uri(id, 'test'),
          self.class.build_params(params)
        )
      end

      # Launches an email and return the response object
      def launch(params = {})
        # Supports receiving an array of List objects (Object Oriented)
        lists = params.delete(:lists)
        if lists
          params[:list_ids] ||= []
          params[:list_ids] += lists.map do |list|
            list.respond_to?(:id) ? list.id : list.to_i
          end
          # Remove duplicate IDs, if any
          params[:list_ids].uniq!
        end

        Response.new self.class.post(
          self.class.resource_uri(id),
          self.class.build_params(params)
        )
      end

      def unschedule(params = {})
        Response.new self.class.post(
          self.class.resource_uri(id, 'unschedule'),
          self.class.build_params(params)
        )
      end

      def opens_stats(options = {})
        detailed_stat(:opens)
      end

      def clicks_stats(options = {})
        detailed_stat(:clicks)
      end

      def unsubscribes_stats(options = {})
        detailed_stat(:unsubscribes)
      end

      private

      def detailed_stat(stat_name, options = {})
        stat_name = stat_name.to_s
        unless %w(opens clicks unsubscribes).include?(stat_name)
          raise NotImplementedError,
                "'#{stat_name}' stat is not supported for the #{class_name} class"
        end

        if response.links && response.links.has_key?(stat_name)
          uri = response.links[stat_name]['url']
        else
          uri = self.class.resource_uri(id, 'stats', stat_name)
        end

        Response.new self.class.get(uri, self.class.build_query_params(options))
      end
    end
  end
end
