module VSafe
  class PaymentStatus
    BANK_DENIED = 1
    VSAFE_PENDED = 2
    VSAFE_DENIED = 3
    AUTHORIZED = 5
    SUCCESSFUL = 10

    attr_reader :code

    def initialize(code)
      @code = code.to_i
    end
  end
end
