# Client errors that can be raised from VerticalResponse API response errors.

module VerticalResponse
  module API
    class Error < StandardError
      attr_accessor :code, :api_response
    end

    class ConfigurationError < Error; end
  end
end
