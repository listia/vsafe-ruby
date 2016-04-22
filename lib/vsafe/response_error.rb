module VSafe
  class ResponseError
    GENERAL_SYSTEM_FAILURE = 1
    PARAMETER_REQUIRED = 510
    PARAMETER_EXCEEDS_MAX_LENGTH = 511
    PARAMETER_IS_NOT_VALID = 512
    PARAMETER_IS_INVALID = 514
    LOGIN_FAILED = 1001
    PAYMENT_NOT_FOUND = 1002
    PAYMENT_IS_ALREADY_CONFIRMED = 1003
    PAYMENT_NOT_AUTHORIZED = 1004
    PARTNER_NOT_ACTIVE = 1005
    AMOUNT_LARGER_THAN_ORIGINAL_AUTHORIZATION = 1006
    AUTHORIZATION_IS_ALREADY_EXPIRED = 1007
    ORIGINAL_TRANSACTION_WAS_FROM_A_DIFFERENT_INTERFACE = 1008

    SUGGESTED_MESSAGES = {
      GENERAL_SYSTEM_FAILURE => "System not available. Please try again later.".freeze,
      PARAMETER_IS_INVALID => "Please select a correct value.".freeze,
      LOGIN_FAILED => "System not available. Please try again later.".freeze,
      PARTNER_NOT_ACTIVE => "System not available. Please try again later.".freeze,
      AUTHORIZATION_IS_ALREADY_EXPIRED => "Please provide your payment information again.".freeze,
      ORIGINAL_TRANSACTION_WAS_FROM_A_DIFFERENT_INTERFACE => "Please try again later.".freeze
    }.freeze

    attr_reader :code,
                :text,
                :suggested_message

    def initialize(response_body)
      @code = response_body["ResponseCode"].to_i
      @text = response_body["ResponseText"]
      @suggested_message = SUGGESTED_MESSAGES[code]
    end
  end
end
