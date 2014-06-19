require 'httparty'

require_relative 'client.rb'
require_relative 'contact.rb'
require_relative 'custom_field.rb'
require_relative 'email.rb'
require_relative 'error.rb'
require_relative 'list.rb'
require_relative 'message.rb'
require_relative 'oauth.rb'
require_relative 'resource.rb'
require_relative 'response.rb'
require_relative 'social_post.rb'

module VerticalResponse
  CONFIG = { 
    host: 'vrapi.verticalresponse.com',
    port: "",
    protocol: 'https'
  }
end