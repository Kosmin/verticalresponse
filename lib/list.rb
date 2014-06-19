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
        # Base URI for the List resource
        def base_uri(*args)
          @base_uri ||= File.join(super.to_s, 'lists')
        end
      end

      def initialize(*args)
        super
        @contact_class = self.class.class_for_resource(Contact, id)
        @message_class = self.class.class_for_resource(Message, id)
      end

      # Returns all the messages targetted to the current list
      def messages(options = {})
        @message_class.all(options)
      end

      # Returns all the contacts that belong to the list
      def contacts(options = {})
        @contact_class.all(options)
      end

      def find_contact(contact_id, options = {})
        @contact_class.find(contact_id, options)
      end

      # Creates a contact for the list with the parameters provided
      def create_contact(params)
        @contact_class.create(params)
      end

      # Creates contacts in batch for the list with the parameters provided
      def create_contacts(params)
        params = { :contacts => params } if params.is_a?(Array)
        @contact_class.create(params)
      end

      # Deletes a contact from the list
      def delete_contact(contact)
        # Make a copy of the original contact but embedding the request
        # within the list resource
        contact_to_delete = @contact_class.new(contact.response)
        contact_to_delete.delete
      end

      # Deletes contacts in batch from the list
      def delete_contacts(contact_emails)
        Response.new @contact_class.delete(
          @contact_class.resource_uri,
          self.class.build_params({ :contacts => contact_emails })
        )
      end
    end
  end
end
