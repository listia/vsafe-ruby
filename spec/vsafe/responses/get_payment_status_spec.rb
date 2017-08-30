require "spec_helper"
require "vsafe/responses/get_session_tags"

RSpec.describe VSafe::Responses::GetPaymentStatus do
  let(:success_body) {
    {
      "ResponseCode" => "0",
      "Amount" => "5.0000",
      "PaymentID" => "1234",
      "PaymentStatus" => "3",
      "TransactionID" => "23",
    }
  }
  let(:http_response) { double(:response, success?: true, parsed_response: success_body) }
  subject(:response) { VSafe::Responses::GetPaymentStatus.new(http_response) }

  it { is_expected.to have_attributes(response_code: '0') }
  it { is_expected.to have_attributes(amount: '5.0000') }
  it { is_expected.to have_attributes(payment_id: '1234') }
  it { is_expected.to have_attributes(transaction_id: '23') }
  it 'should have correct payment status code' do
    expect(response.payment_status.code).to eq(3)
  end
end
