require "spec_helper"
require "vsafe/auth_result"

RSpec.describe VSafe::AuthResult do
  describe ".new" do
    let(:code) { 1 }

    it "sets the code" do
      expect(VSafe::AuthResult.new(code.to_s).code).to eq(code)
    end
  end
end
