module BubbleWrap

  # The HTTP module provides a simple interface to make HTTP requests.
  #
  # TODO: preflight support, easier/better cookie support, better error handling
  module HTTP

    # Make a GET request and process the response asynchronously via a block.
    #
    # @examples
    #  # Simple GET request printing the body
    #   BubbleWrap::HTTP.get("https://api.github.com/users/mattetti") do |response|
    #     p response.body.to_str
    #   end
    #
    #  # GET request with basic auth credentials
    #   BubbleWrap::HTTP.get("https://api.github.com/users/mattetti", {credentials: {username: 'matt', password: 'aimonetti'}}) do |response|
    #     p response.body.to_str # prints the response's body
    #   end
    #

    [:get, :post, :put, :delete, :head, :options, :patch].each do |http_verb|

      define_singleton_method(http_verb) do |url, options = {}, &block|
        options[:action] = block if block
        HTTP::Query.new(url, http_verb, options)
      end

    end

    module Patch
      module_function
      def use_weak_callbacks?
        if BubbleWrap.respond_to?("use_weak_callbacks?")
          return BubbleWrap.use_weak_callbacks?
        end
        true
      end

      def ios?
        Kernel.const_defined?(:UIApplication)
      end

      def osx?
        Kernel.const_defined?(:NSApplication)
      end

      def debug?
        if BubbleWrap.respond_to?("debug?")
          return BubbleWrap.debug?
        end
        false
      end

      def create_uuid
        uuid = CFUUIDCreate(nil)
        CFUUIDCreateString(nil, uuid)
      end

      module JSON
        module_function
        def generate(obj)
          NSJSONSerialization.dataWithJSONObject(obj, options:0, error:nil).to_str
        end

        def parse(str_data, &block)
          return nil unless str_data
          data = str_data.respond_to?(:to_data) ? str_data.to_data : str_data
          opts = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
          error = Pointer.new(:id)
          obj = NSJSONSerialization.JSONObjectWithData(data, options:opts, error:error)
          raise ParserError, error[0].description if error[0]
          if block_given?
            yield obj
          else 
            obj
          end
        end
      end

      module NetworkIndicator
        module_function
        def show
          if BubbleWrap.const_defined?("NetworkIndicator")
            BubbleWrap::NetworkIndicator.show
          end
        end

        def hide
          if BubbleWrap.const_defined?("NetworkIndicator")
            BubbleWrap::NetworkIndicator.hide
          end
        end
      end
    end

  end
end

class InvalidURLError < StandardError; end
class InvalidFileError < StandardError; end
