require "spec_helper"
require "vsafe/responses/charge_sale"

RSpec.describe VSafe::Responses::ChargeSale do
  let(:avs_result_code) { "1" }
  let(:auth_result_code) { "2" }
  let(:cvn_result_code) { "3" }
  let(:charge_permanent_token) { "4" }
  let(:payment_acquirer_name) { "payment_acquirer_name" }
  let(:payment_id) { "payment_id" }
  let(:payment_id_pk) { "payment_id_pk" }
  let(:payment_status) { "5" }
  let(:success_body) {
    {
      "AVSResultCode" => avs_result_code,
      "AuthResultCode" => auth_result_code,
      "CVNResultCode" => cvn_result_code,
      "ChargePermanentToken" => charge_permanent_token,
      "PaymentAcquirerName" => payment_acquirer_name,
      "PaymentID" => payment_id,
      "PaymentID_pk" => payment_id_pk,
      "PaymentStatus" => payment_status
    }
  }
  let(:http_response) { double(:response, success?: true, parsed_response: success_body) }
  let(:response) { VSafe::Responses::ChargeSale.new(http_response) }
  context "#avs_result" do
    it "returns value" do
      expect(response.avs_result.code).to eq(avs_result_code.to_i)
    end
  end

  context "#auth_result" do
    it "returns value" do
      expect(response.auth_result.code).to eq(auth_result_code.to_i)
    end
  end

  context "#charge_permanent_token" do
    it "returns value" do
      expect(response.charge_permanent_token).to eq(charge_permanent_token)
    end
  end

  context "#payment_acquirer_name" do
    it "returns value" do
      expect(response.payment_acquirer_name).to eq(payment_acquirer_name)
    end
  end

  context "#payment_id" do
    it "returns value" do
      expect(response.payment_id).to eq(payment_id)
    end
  end

  context "#payment_id_pk" do
    it "returns value" do
      expect(response.payment_id_pk).to eq(payment_id_pk)
    end
  end

  context "#payment_status" do
    it "returns value" do
      expect(response.payment_status.code).to eq(payment_status.to_i)
    end
  end
end
