require "vsafe/config"
require "vsafe/charge_source"
require "vsafe/response"
require "vsafe/responses/get_session_tags"
require "vsafe/responses/charge_authorize"
require "vsafe/responses/charge_confirm"
require "vsafe/responses/reverse_payment"
require "vsafe/responses/charge_account_to_temporary_token"
require "vsafe/responses/charge_sale"
require "vsafe/responses/validate_charge_account"
require "securerandom"
require "uri"

module VSafe
  class Client
    SANDBOX_FINGERPRINT_PATH = "ThreatMetrixUIRedirector".freeze
    FINGERPRINT_PATH = "PaySafeUIRedirector".freeze
    # We should only use JSONP_SERVICE_PATH for charge_acct_to_tempory_token call in web js.
    JSONP_SERVICE_PATH = "GatewayProxyJSON/Service".freeze
    SERVICE_PATH = "GatewayProxy/Service".freeze
    REQUEST_CONTENT_TYPE = "application/json; charset=utf-8".freeze

    attr_reader :config

    def initialize
      # dup config in case we need to override default settings
      @config = VSafe.config.dup

      yield config if block_given?
    end

    def get_session_tags
      params = {
        TransactionID: SecureRandom.uuid
      }

      VSafe::Responses::GetSessionTags.new(request(service_url("GetSessionTags"), params))
    end

    def charge_authorize(params)
      VSafe::Responses::ChargeAuthorize.new(request(service_url("ChargeAuthorize"), params))
    end

    def charge_confirm(params)
      VSafe::Responses::ChargeConfirm.new(request(service_url("ChargeConfirm"), params))
    end

    def reverse_payment(params)
      VSafe::Responses::ReversePayment.new(request(service_url("ReversePayment"), params))
    end

    def heartbeat
      VSafe::Response.new(request(service_url("HeartBeat")))
    end

    def charge_sale(params)
      VSafe::Responses::ChargeSale.new(request(service_url("ChargeSale"), params))
    end

    def validate_charge_account(params)
      VSafe::Responses::ValidateChargeAccount.new(request(service_url("ValidateChargeAccount"), params))
    end

    def service_url(endpoint = nil, jsonp = false)
      parts = [
        config.url,
        jsonp ? JSONP_SERVICE_PATH : SERVICE_PATH
      ]
      parts << endpoint if endpoint

      File.join(parts)
    end

    def fingerprint_url
      @_fingerprint_url ||= URI.join(config.url, config.sandbox ? SANDBOX_FINGERPRINT_PATH : FINGERPRINT_PATH).to_s
    end

    private

    def request(url, params = {})
      options = {
        timeout: config.request_timeout,
        body: params.merge(
          AccountName: config.account_name,
          Password: config.password
        ).to_json,
        headers: {
          "Content-Type" => REQUEST_CONTENT_TYPE
        }
      }

      # The HTTPS endpoint for VSafe Sandbox has an outdated SSL version.
      # We need to do this so that we can actually connect.
      if config.sandbox
        options[:ssl_version] = :TLSv1
      end

      response = HTTParty.post(url, options)
    end
  end
end
