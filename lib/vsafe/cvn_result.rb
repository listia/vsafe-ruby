module VSafe
  class CvnResult
    INVALID = 15
    MATCH = 17
    NOT_MATCHED = 19
    CHECK_NOT_PROCESSED = 20
    SHOULD_BE_AVAILABLE = 22
    NOT_SUPPORTED_BY_ISSUER = 23
    NOT_SENT = 45

    attr_reader :code

    def initialize(code)
      @code = code.to_i
    end
  end
end
