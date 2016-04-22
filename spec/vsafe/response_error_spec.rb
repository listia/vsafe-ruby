require "spec_helper"
require "vsafe/response_error"

RSpec.describe VSafe::ResponseError do
  let(:response_body) {
    {
      "ResponseCode" => "1",
      "ResponseText" => "text"
    }
  }
  describe ".new" do
    it "initializes fine" do
      expect { VSafe::ResponseError.new(response_body) }.to_not raise_error
    end
  end

  describe "#code" do
    it "returns code" do
      expect(VSafe::ResponseError.new(response_body).code).to eq(1)
    end
  end

  describe "#text" do
    it "returns text" do
      expect(VSafe::ResponseError.new(response_body).text).to eq("text")
    end
  end

  describe "#suggested_message" do
    it "returns message" do
      VSafe::ResponseError::SUGGESTED_MESSAGES.keys.each do |code|
        response_body["ResponseCode"] = code
        expect(VSafe::ResponseError.new(response_body).suggested_message).to eq(VSafe::ResponseError::SUGGESTED_MESSAGES[code])
      end
    end
  end
end
