require "spec_helper"
require "vsafe/payment_status"

RSpec.describe VSafe::PaymentStatus do
  describe ".new" do
    let(:code) { 1 }

    it "sets the code" do
      expect(VSafe::PaymentStatus.new(code.to_s).code).to eq(code)
    end
  end
end
