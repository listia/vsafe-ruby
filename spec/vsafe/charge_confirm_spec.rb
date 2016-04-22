require "spec_helper"
require "vsafe/responses/charge_confirm"

RSpec.describe VSafe::Responses::ChargeConfirm do
  let(:payment_status) { "1" }
  let(:success_body) {
    {
      "ResponseCode" => "0",
      "ResponseText" => "Success",
      "PaymentStatus" => payment_status
    }
  }
  let(:http_response) { double(:response, success?: true, parsed_response: success_body) }

  context "#payment_status" do
    it "returns value" do
      expect(VSafe::Responses::ChargeConfirm.new(http_response).payment_status.code).to eq(payment_status.to_i)
    end
  end
end
