module VSafe
  class Config
    DEFAULT_REQUEST_TIMEOUT = 20 # seconds
    DEFAULT_SANDBOX_URL = "https://paysafesandbox.ecustomersupport.com".freeze
    DEFAULT_PRODUCTION_URL = "https://paysafe.ecustomerpayments.com".freeze
    DEFAULT_JSONP_SERVICE_PATH = "GatewayProxyJSON/Service".freeze
    DEFAULT_SERVICE_PATH = "GatewayProxy/Service".freeze

    attr_accessor :sandbox_url,
                  :production_url,
                  :sandbox,
                  :account_name,
                  :password,
                  :service_path,
                  :jsonp_service_path,
                  :request_timeout

    def initialize
      # Set sandbox to true by default
      @sandbox = true
      @service_path = DEFAULT_SERVICE_PATH
      @jsonp_service_path = DEFAULT_JSONP_SERVICE_PATH
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @sandbox_url = DEFAULT_SANDBOX_URL
      @production_url = DEFAULT_PRODUCTION_URL
    end

    def url
      sandbox ? @sandbox_url : @production_url
    end
  end
end
