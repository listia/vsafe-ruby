require "spec_helper"
require "vsafe/card_type"

RSpec.describe VSafe::CardType do
  describe ".new" do
    let(:code) { 1 }

    it "sets the code" do
      expect(VSafe::CardType.new(code.to_s).code).to eq(code)
    end
  end

  describe ".description" do
    let(:card_type_codes) {
      [
        VSafe::CardType::AMERICAN_EXPRESS,
        VSafe::CardType::VISA,
        VSafe::CardType::MASTERCARD,
        VSafe::CardType::DISCOVER,
        VSafe::CardType::DINERS_CLUB,
        VSafe::CardType::OPTIMA
      ]
    }

    let(:card_type_descriptions) {
      [
        "American Express",
        "Visa",
        "MasterCard",
        "Discover",
        "Diners Club",
        "Optima"
      ]
    }

    it "returns description" do
      index = 0
      card_type_codes.each  do |code|
        expect(VSafe::CardType.new(code).description).to eq(card_type_descriptions[index])
        index += 1
      end
    end
  end
end
