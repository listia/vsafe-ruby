require "vsafe/response_error"
require "vsafe/request_error"

module VSafe
  class Response
    SUCCESS_RESPONSE_CODE = "0".freeze

    attr_reader :response, :error

    def self.define_attribute_mapping(attr_method, response_parameter, wrapper = nil)
      define_method(attr_method) do
        memo_variable = "@_#{attr_method}"
        memo_value = instance_variable_get(memo_variable)
        return memo_value if instance_variable_defined?(memo_variable)

        memo_value = if wrapper && response.parsed_response[response_parameter]
          wrapper.new(response.parsed_response[response_parameter])
        else
          response.parsed_response[response_parameter]
        end

        instance_variable_set(memo_variable, memo_value)
      end
    end

    def initialize(response)
      @response = response

      if response.success?
        unless success?
          @error = ResponseError.new(response.parsed_response)
        end
      else
        raise RequestError.new(response)
      end
    end

    def success?
      response.success? &&
        response.parsed_response["ResponseCode"] == SUCCESS_RESPONSE_CODE
    end

    def to_hash
      response.parsed_response || {}
    end
  end
end
