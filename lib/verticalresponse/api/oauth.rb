# This class provides users the ability to generate oAuth tokens for the
# VerticalResponse API.
#
# Check the examples/sample code to know how to use this class.

require_relative 'client'

module VerticalResponse
  module API
    class OAuth < Client
      # We expect HTML format as the API might redirect to a signin page or
      # return errors in HTML format
      format :html

      def initialize(access_token)
        @access_token = access_token
      end

      class << self
        # Overwrite this method as we don't need to setup headers for
        # OAuth calls
        def assign_headers(*args)
        end

        def resource_uri_suffix
          ['oauth']
        end

        # client_id is the application key
        def authorize(redirect_uri = "", client_id = "")
          get(
            resource_uri('authorize'),
            build_query_params({ :client_id => client_id, :redirect_uri => redirect_uri })
          )
        end

        def access_token(auth_code,
                         redirect_uri = "",
                         client_id = "",
                         client_secret = "")
          get(
            resource_uri('access_token'),
            build_query_params({
              :client_id => client_id,
              :client_secret => client_secret,
              :code => auth_code,
              :redirect_uri => redirect_uri
            })
          )
        end
      end

      # ============================================================
      # We want to access instances of OAuth with OOP, so we'll include
      # some wrappers that let us use do the following:
      #   client = OAuth.new(access_token)
      #   client.lists
      #   client.contacts
      #
      # Please note, using static libraries isn't "object-oriented".
      # Using instances is. The client in the example above is an
      # example of an instance. This whole gem uses libraries
      # instead of instances which is kindof bad.
      #
      # TODO: this whole gem should be more object-oriented, but for
      # now this should work
      # ============================================================
      def lists(params = {})
        params.merge!({access_token: @access_token})
        VerticalResponse::API::List.all(params)
      end

      # Afterwards, can use 'create_contact', etc.
      def find_list(list_id, params = {})
        params.merge!({access_token: @access_token})
        VerticalResponse::API::List.find(list_id, params)
      end

      def contacts(params = {}, *path_prefix)
        params.merge!({access_token: @access_token})
        VerticalResponse::API::Contact.all(params, path_prefix)
      end

      def find_contact(contact_id, params = {})
        params.merge!({access_token: @access_token})
        VerticalResponse::API::Contact.find(contact_id, params)
      end

      def find_contact_by_email(email, params = {})
        params.merge!({access_token: @access_token})
        params.merge!({email_address: email})
        VerticalResponse::API::Contact.find_by_email(params)
      end

      # One or more contacts; if creating more => custom fields aren't created remotely
      # Attempt to create custom fields remotely => error
      #
      # For multiple, use contacts: [{...},{...}]
      def create_contacts(contact_details, *path_prefix)
        contact_details = { contacts: contact_details } if contact_details.is_a?(Array) 
        VerticalResponse::API::Contact.create(
          contact_details.merge(access_token: @access_token), 
          path_prefix
        )
      end

      def custom_fields(params = {})
        params.merge!({access_token: @access_token})
        VerticalResponse::API::CustomField.all(params)
      end
    end
  end
end
