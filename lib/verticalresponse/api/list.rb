# Class that represents a list resource from the VerticalResponse API.
# It has the ability to make REST calls to the API, as well as to wrap
# the list objects we get as response.
#
# NOTE: This class does not necessarily include all the available methods
# the API has for the list resource. You can consider this an initial approach
# for an object oriented solution that you can expand according to your needs.

require_relative 'contact'

module VerticalResponse
  module API
    class List < Resource
      class << self
        def resource_uri_suffix
          ['lists']
        end
      end

      def initialize(*args)
        super
        @contact_class = self.class.class_for_resource(Contact, id)
        @message_class = self.class.class_for_resource(Message, id)
      end

      # Returns all the messages targetted to the current list
      def messages(options = {})
        @access_token ||= options[:access_token]
        @message_class.all(options.merge(access_token: @access_token))
      end

      # Returns all the contacts that belong to the list
      def contacts(options = {})
        @access_token ||= options[:access_token]
        @contact_class.all(options.merge(access_token: @access_token))
      end

      def find_contact(contact_id, options = {})
        @access_token ||= options[:access_token]
        @contact_class.find(contact_id, options.merge(access_token: @access_token))
      end

      def find_contact_by_email(email, options = {})
        @access_token ||= options[:access_token]
        @contact_class.find_by_email(options.merge(access_token: @access_token, email_address: email))
      end

      # Creates a contact for the list with the parameters provided
      def create_contact(params)
        @access_token ||= params[:access_token]
        @contact_class.create(params.merge(access_token: @access_token))
      end

      # Creates contacts in batch for the list with the parameters provided
      def create_contacts(params)
        @access_token ||= params[:access_token]
        params = { :contacts => params } if params.is_a?(Array)
        @contact_class.create(params.merge(access_token: @access_token))
      end

      # Deletes a contact from the list
      def delete_contact(contact)
        # Make a copy of the original contact but embedding the request
        # within the list resource
        contact_to_delete = @contact_class.new(contact.response)
        contact_to_delete.delete
      end

      # Deletes contacts in batch from the lists
      def delete_contacts(contact_emails)
        Response.new @contact_class.delete(
          @contact_class.resource_uri,
          self.class.build_params({ :contacts => contact_emails })
        )
      end
    end
  end
end
