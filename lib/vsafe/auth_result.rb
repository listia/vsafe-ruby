module VSafe
  class AuthResult
    INSUFFICENT_FUNDS = 1

    attr_reader :code

    def initialize(code)
      @code = code.to_i
    end
  end
end
