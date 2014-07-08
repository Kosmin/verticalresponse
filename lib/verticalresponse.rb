require 'httparty'

require_relative 'verticalresponse/api/oauth.rb'

require_relative 'verticalresponse/api/client.rb'
require_relative 'verticalresponse/api/contact.rb'
require_relative 'verticalresponse/api/custom_field.rb'
require_relative 'verticalresponse/api/email.rb'
require_relative 'verticalresponse/api/error.rb'
require_relative 'verticalresponse/api/list.rb'
require_relative 'verticalresponse/api/message.rb'
require_relative 'verticalresponse/api/resource.rb'
require_relative 'verticalresponse/api/response.rb'
require_relative 'verticalresponse/api/social_post.rb'

module VerticalResponse
  API_VERSION  = "v1".freeze

  CONFIG = { 
    host: 'vrapi.verticalresponse.com',
    port: "",
    protocol: 'https'
  }
end

$LOAD_PATH << File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))
