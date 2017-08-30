require "spec_helper"
require "vsafe/client"
require "vsafe/config"
require "vsafe/response"
require "httparty"

RSpec.describe VSafe::Client do
  let(:body) {
    {
      ResponseCode: VSafe::Response::SUCCESS_RESPONSE_CODE
    }.to_json
  }
  let(:client) { VSafe::Client.new }
  let(:params) { {"test" => 1} }

  def assert_vsafe_request(request)
    expect(request.headers["Content-Type"]).to eq(VSafe::Client::REQUEST_CONTENT_TYPE)

    json = JSON.parse(request.body)
    expect(json["AccountName"]).to eq(client.config.account_name)
    expect(json["Password"]).to eq(client.config.password)

    json
  end

  def stub_vsafe_request(endpoint)
    stub_request(:post, client.service_url(endpoint)) do |request|
      json = assert_vsafe_request(request)

      params.each do |key, value|
        expect(json[key]).to eq(value)
      end
    end.to_return(body: body, headers: { "Content-Type" => VSafe::Client::REQUEST_CONTENT_TYPE })
  end

  describe ".new" do
    context "when block is given" do
      it "yields block" do
        yielded_config = nil

        client = VSafe::Client.new do |config|
          yielded_config = config
        end

        expect(yielded_config).to be_a(VSafe::Config)
        expect(yielded_config).to eq(client.config)
      end
    end
  end

  describe "#get_session_tags" do
    it "returns response" do
      stub_request(:post, client.service_url("GetSessionTags")) do |request|
        json = assert_vsafe_request(request)
        expect(json["TransactionID"]).not_to be_nil
      end.to_return(body: body, headers: { "Content-Type" => VSafe::Client::REQUEST_CONTENT_TYPE })

      response = client.get_session_tags

      expect(response).to be_a(VSafe::Responses::GetSessionTags)
      expect(response).to be_success
    end
  end

  describe "#charge_authorize" do
    it "returns response" do
      stub_vsafe_request("ChargeAuthorize")

      response = client.charge_authorize(params)

      expect(response).to be_a(VSafe::Responses::ChargeAuthorize)
      expect(response).to be_success
    end
  end

  describe "#charge_confirm" do
    it "returns response" do
      stub_vsafe_request("ChargeConfirm")

      response = client.charge_confirm(params)

      expect(response).to be_a(VSafe::Responses::ChargeConfirm)
      expect(response).to be_success
    end
  end

  describe "#reverse_payment" do
    it "returns response" do
      stub_vsafe_request("ReversePayment")

      response = client.reverse_payment(params)

      expect(response).to be_a(VSafe::Responses::ReversePayment)
      expect(response).to be_success
    end
  end

  describe "#heartbeat" do
    it "returns response" do
      stub_request(:post, client.service_url("HeartBeat")) do |request|
        json = assert_vsafe_request(request)
      end.to_return(body: body, headers: { "Content-Type" => VSafe::Client::REQUEST_CONTENT_TYPE })

      response = client.heartbeat

      expect(response).to be_a(VSafe::Response)
      expect(response).to be_success
    end
  end

  describe "#charge_sale" do
    it "returns response" do
      stub_vsafe_request("ChargeSale")

      response = client.charge_sale(params)

      expect(response).to be_a(VSafe::Responses::ChargeSale)
      expect(response).to be_success
    end
  end

  describe "#validate_charge_account" do
    it "returns response" do
      stub_vsafe_request("ValidateChargeAccount")

      response = client.validate_charge_account(params)

      expect(response).to be_a(VSafe::Responses::ValidateChargeAccount)
      expect(response).to be_success
    end
  end

  describe "#get_payment_status" do
    it "returns response" do
      stub_vsafe_request("GetPaymentStatus")
      response = client.get_payment_status(params)

      expect(response).to be_a(VSafe::Responses::GetPaymentStatus)
      expect(response).to be_success
    end
  end

  describe "#service_url" do
    shared_examples_for "returns url" do |jsonp|
      context "when endpoint defined" do
        let(:endpoint) { "foo" }

        it "returns endpoint url" do
          expect(client.service_url(endpoint, jsonp)).to eq("#{base_uri}/#{endpoint}")
        end
      end

      describe "when endpoint not defined" do
        let(:endpoint) { nil }

        it "returns base url" do
          expect(client.service_url(endpoint, jsonp)).to eq(base_uri)
        end
      end
    end

    context "when jsonp is false" do
      let(:base_uri) { 'https://base.url/GatewayProxy/Service'}
      before do
        expect(client.config).to receive(:url).and_return(base_uri)
      end
      it_behaves_like "returns url"
    end

    context "when jsonp is true" do
      let(:base_uri) { 'https://base.url/GatewayProxyJSON/Service'}
      before do
        expect(client.config).to receive(:jsonp_url).and_return(base_uri)
      end
      it_behaves_like "returns url", true
    end
  end

  describe "#fingerprint_url" do
    context "when sandbox" do
      before do
        allow(client.config).to receive(:sandbox).and_return(true)
      end

      it "use url when jsonp url is not set" do
        client.config.sandbox_jsonp_url = 'https://sandbox.url/GatewayProxy/Service'
        expect(client.fingerprint_url).to eq("https://sandbox.url/#{VSafe::Client::SANDBOX_FINGERPRINT_PATH}")
      end

      it "uses the jsonp_url when set" do
        client.config.sandbox_jsonp_url = 'https://google.com/'
        expect(client.fingerprint_url).to eq("https://google.com/#{VSafe::Client::SANDBOX_FINGERPRINT_PATH}")
      end
    end

    context "when not sandbox" do
      before do
        allow(client.config).to receive(:sandbox).and_return(false)
      end

      it "returns url" do
        allow(client.config).to receive(:jsonp_url).and_return('https://google.com/')
        expect(client.fingerprint_url).to eq("https://google.com/#{VSafe::Client::FINGERPRINT_PATH}")
      end
    end
  end
end
