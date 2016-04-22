module VSafe
  class Config
    DEFAULT_REQUEST_TIMEOUT = 20 # seconds
    DEFAULT_SANDBOX_URL = "https://paysafesandbox.ecustomersupport.com".freeze
    DEFAULT_PRODUCTION_URL = "https://paysafe.ecustomerpayments.com".freeze

    attr_accessor :sandbox,
                  :account_name,
                  :password,
                  :request_timeout,
                  :url

    def initialize(options = {})
      # Set sandbox to true by default
      @sandbox = true
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @url = sandbox ? DEFAULT_SANDBOX_URL : DEFAULT_PRODUCTION_URL

      options.each do |key, value|
        public_send("#{key}=", value)
      end
    end
  end
end
