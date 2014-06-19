# This is the base class for a VerticalResponse resource.
# It contains common object oriented functionality that other resource classes
# can use to interact with the API.

require_relative 'client'

module VerticalResponse
  module API
    class Resource < Client
      class << self
        def class_for_resource(original_class, id = nil)
          # Create a new anonymous class to prevent conflicts with other classes
          new_class = Class.new(original_class)
          new_class.embed_resource(resource_name, id)
          new_class
        end

        # Exclude methods that are not supported by the current resource API.
        # This applies for common methods that are shared across all classes:
        #   - Class methods: all, find, create
        #   - Instance methods: update, delete, stats
        def exclude_methods(*methods)
          @excluded_methods = methods
        end

        def validate_supported_method!(method)
          if @excluded_methods && @excluded_methods.include?(method.to_sym)
            raise NotImplementedError,
              "This method is not supported for the #{ class_name } class"
          end
        end

        def class_name
          # Use the superclass name if the current class name is not defined
          # (e.g. for anonymous classes)
          name || superclass.name
        end

        def resource_name
          # Manually pluralize just by adding an 's' and underscore manually
          # We want this wrapper to be Rails-independent
          "#{ class_name.split('::').last.gsub(/(.)([A-Z])/,'\1_\2').downcase }s"
        end

        def id_regexp
          /\d+/
        end

        def id_attribute_name
          'id'
        end

        # Get the ID of a resource based on a given URL
        def resource_id_from_url(url)
          url.match(/#{ resource_name }\/(#{ id_regexp })/)[1]
        end

        ##################################
        # Common object oriented methods #
        ##################################

        # Returns a collection of current class objects.
        # Useful for when we need to have an object oriented way to
        # handle a list of items from an API response
        def object_collection(response)
          response.handle_collection do |response_item|
            self.new(response_item)
          end
        end

        # Returns all the objects of the current class
        def all(options = {})
          validate_supported_method!(:all)

          response = Response.new get(resource_uri, build_query_params(options))

          object_collection(response)
        end

        # Find and return an object of the current class based on its ID
        def find(id, options = {})
          validate_supported_method!(:find)

          response = Response.new get(resource_uri(id), build_query_params(options))

          self.new(response)
        end

        # Creates a new object of the current class with the parameters provided
        def create(params)
          validate_supported_method!(:create)

          response = Response.new post(
            resource_uri,
            build_params(params)
          )
          self.new(response)
        end
      end

      # Returns the ID of the current object based on the response
      def id
        if @id.nil? && response
          if response.attributes && response.attributes.has_key?(self.class::id_attribute_name)
            @id = response.attributes[self.class::id_attribute_name]
          elsif url
            # This case is useful if we need the ID right after a call
            # that does not return any atributes, like create
            @id = self.class.resource_id_from_url(url)
          end
        end
        @id
      end

      def url
        response.url
      end

      def update(params)
        self.class.validate_supported_method!(:update)

        response = Response.new self.class.put(
          self.class.resource_uri(id),
          self.class.build_params(params)
        )
        self.class.new(response)
      end

      def delete(params = {})
        self.class.validate_supported_method!(:delete)

        Response.new self.class.delete(
          self.class.resource_uri(id),
          self.class.build_params(params)
        )
      end

      # Returns the summary stats for the current object
      def stats(options = {})
        self.class.validate_supported_method!(:stats)

        if response.links && response.links.has_key?('stats')
          uri = response.links['stats']['url']
        else
          uri = self.class.resource_uri(id, 'stats')
        end

        Response.new self.class.get(uri, self.class.build_query_params(options))
      end
    end
  end
end
