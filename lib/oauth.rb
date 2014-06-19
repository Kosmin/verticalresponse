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

      def lists
        VerticalResponse::API::List.all({"access_token" => @access_token})
      end

      def contacts
        VerticalResponse::API::Contact.all({"access_token" => @access_token})
      end

      def get_list(list_id)
        VerticalResponse::API::List.find(list_id, {"access_token" => @access_token})
      end

      class << self
        # Overwrite this method as we don't need to setup headers for
        # OAuth calls
        def assign_headers(*args)
        end

        # Base URI for the OAuth calls
        def base_uri(*args)
          @base_uri ||= File.join(super.to_s, 'oauth')
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
    end
  end
end
