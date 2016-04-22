require "spec_helper"
require "vsafe/cvn_result"

RSpec.describe VSafe::CvnResult do
  describe ".new" do
    let(:code) { 1 }

    it "sets the code" do
      expect(VSafe::CvnResult.new(code.to_s).code).to eq(code)
    end
  end
end
