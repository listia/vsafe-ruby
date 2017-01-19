module VSafe
  class Config
    DEFAULT_REQUEST_TIMEOUT = 20 # seconds
    DEFAULT_SANDBOX_URL = "https://paysafesandbox.ecustomersupport.com/GatewayProxy/Service".freeze
    DEFAULT_SANDBOX_JSONP_URL = "https://paysafesandbox.ecustomersupport.com/GatewayProxyJSON/Service".freeze

    DEFAULT_PRODUCTION_URL = "https://paysafe.ecustomerpayments.com/GatewayProxy/Service".freeze
    DEFAULT_PRODUCTION_JSONP_URL = "https://paysafe.ecustomerpayments.com/GatewayProxyJSON/Service".freeze

    attr_accessor :sandbox_url,
                  :production_url,
                  :sandbox_jsonp_url,
                  :production_jsonp_url,
                  :sandbox,
                  :account_name,
                  :password,
                  :request_timeout,
                  :logger

    def initialize
      # Set sandbox to true by default
      @sandbox = true
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @sandbox_url = DEFAULT_SANDBOX_URL
      @production_url = DEFAULT_PRODUCTION_URL
      @sandbox_jsonp_url = DEFAULT_SANDBOX_JSONP_URL
      @production_jsonp_url = DEFAULT_PRODUCTION_JSONP_URL
    end

    def url
      sandbox ? @sandbox_url : @production_url
    end

    def jsonp_url
      sandbox ? @sandbox_jsonp_url : @production_jsonp_url
    end
  end
end
