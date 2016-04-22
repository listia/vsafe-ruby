require "spec_helper"
require "vsafe/responses/reverse_payment"

RSpec.describe VSafe::Responses::ReversePayment do
  let(:available_refund_amount) { "1.0" }
  let(:payment_acquirer_name) { "payment_acquirer_name" }
  let(:payment_id) { "payment_id" }
  let(:payment_status) { "1" }
  let(:success_body) {
    {
      "AvailableRefundAmount" => available_refund_amount,
      "PaymentAcquirerName" => payment_acquirer_name,
      "PaymentID" => payment_id,
      "PaymentStatus" => payment_status
    }
  }
  let(:http_response) { double(:response, success?: true, parsed_response: success_body) }
  let(:response) { VSafe::Responses::ReversePayment.new(http_response) }

  describe "#available_refund_amount" do
    it "returns value" do
      expect(response.available_refund_amount).to eq(available_refund_amount)
    end
  end

  describe "#payment_acquirer_name" do
    it "returns value" do
      expect(response.payment_acquirer_name).to eq(payment_acquirer_name)
    end
  end

  describe "#payment_id" do
    it "returns value" do
      expect(response.payment_id).to eq(payment_id)
    end
  end
end
