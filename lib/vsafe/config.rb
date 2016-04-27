module VSafe
  class Config
    DEFAULT_REQUEST_TIMEOUT = 20 # seconds
    DEFAULT_SANDBOX_URL = "https://paysafesandbox.ecustomersupport.com".freeze
    DEFAULT_PRODUCTION_URL = "https://paysafe.ecustomerpayments.com".freeze

    attr_accessor :sandbox,
                  :account_name,
                  :password,
                  :request_timeout

    def initialize
      # Set sandbox to true by default
      @sandbox = true
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def url
      sandbox ? DEFAULT_SANDBOX_URL : DEFAULT_PRODUCTION_URL
    end
  end
end
