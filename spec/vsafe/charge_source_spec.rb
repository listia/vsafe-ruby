require "spec_helper"
require "vsafe/charge_source"

RSpec.describe VSafe::ChargeSource do
  describe "constants" do
    it "returns correct string" do
      expect(VSafe::ChargeSource::PPD).to eq("PPD")
      expect(VSafe::ChargeSource::TEL).to eq("TEL")
      expect(VSafe::ChargeSource::WEB).to eq("WEB")
    end
  end
end
