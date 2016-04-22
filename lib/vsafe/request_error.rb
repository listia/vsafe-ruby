require "vsafe/client_error"

module VSafe
  class RequestError < ClientError
    attr_reader :response

    def initialize(response)
      @response = response
    end
  end
end
