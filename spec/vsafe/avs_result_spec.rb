require "spec_helper"
require "vsafe/avs_result"

RSpec.describe VSafe::AvsResult do
  describe ".new" do
    let(:code) { 1 }

    it "returns code" do
      expect(VSafe::AvsResult.new(code.to_s).code).to eq(code)
    end
  end
end
