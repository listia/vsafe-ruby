require "spec_helper"
require "vsafe/responses/charge_account_to_temporary_token"
require "vsafe/card_type"

RSpec.describe VSafe::Responses::ChargeAccountToTemporaryToken do
  let(:body) {
    {
      "ResponseCode" => VSafe::Responses::ChargeAccountToTemporaryToken::SUCCESS_RESPONSE_CODE,
      "ResponseText" => "Success",
      "ChargeAccountNumberToken" => "abc",
      "PaymentDeviceLast4" => "1234",
      "PaymentDeviceTypeCD" => VSafe::CardType::AMERICAN_EXPRESS
    }
  }
  let(:httparty_response) { double(:response, success?: true, parsed_response: body) }

  context "attribute mapping" do
    it "returns value" do
      response = VSafe::Responses::ChargeAccountToTemporaryToken.new(httparty_response)

      expect(response.token).to eq("abc")
      expect(response.last4).to eq("1234")
      expect(response.card_type).to be_kind_of(VSafe::CardType)
      expect(response.card_type.code).to eq(VSafe::CardType::AMERICAN_EXPRESS)
    end
  end
end
