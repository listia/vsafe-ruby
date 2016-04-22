require "spec_helper"
require "vsafe/request_error"

RSpec.describe VSafe::RequestError do
  describe ".new" do
    let(:response) { double }

    it "sets response" do
      expect(VSafe::RequestError.new(response).response).to eq(response)
    end
  end
end
