require "spec_helper"
require "vsafe/response"
require "vsafe/response_error"
require "vsafe/request_error"

RSpec.describe VSafe::Response do
  let(:error_code) { 1001 }
  let(:success_body) {
    {
      "ResponseCode" => VSafe::Response::SUCCESS_RESPONSE_CODE,
      "ResponseText" => "Success"
    }
  }
  let(:fail_body) {
    {
      "ResponseCode" => error_code.to_s,
      "ResponseText" => "Login Failed"
    }
  }

  context ".new" do
    context "when request successful" do
      let(:httparty_response) { double(:response, success?: true, parsed_response: success_body) }

      context "when result is successful" do
        context "when response code is string" do
          it "initializes successfully" do
            response = VSafe::Response.new(httparty_response)

            expect(response.response).to eq(httparty_response)
            expect(response.to_hash).to eq(success_body)
            expect(response.error).to eq(nil)
            expect(response.success?).to eq(true)
          end
        end

        context "when response code is integer" do
          let(:success_body) {
            {
              "ResponseCode" => VSafe::Response::SUCCESS_RESPONSE_CODE.to_i,
              "ResponseText" => "Success"
            }
          }

          it "initializes successfully" do
            response = VSafe::Response.new(httparty_response)

            expect(response.response).to eq(httparty_response)
            expect(response.to_hash).to eq(success_body)
            expect(response.error).to eq(nil)
            expect(response.success?).to eq(true)
          end
        end
      end

      context "when result errored" do
        let(:httparty_response) { double(:response, success?: true, parsed_response: fail_body) }

        it "initializes successful" do
          response = VSafe::Response.new(httparty_response)
          error = response.error
          expect(response.response).to eq(httparty_response)
          expect(response.to_hash).to eq(fail_body)
          expect(error.code).to eq(error_code)
          expect(error.text).to eq("Login Failed")
          expect(response.success?).to eq(false)
        end
      end
    end

    context "when request failed" do
      let(:httparty_response) { double(:response, success?: false, parsed_response: fail_body) }

      it "raises error" do
        expect {
          VSafe::Response.new(httparty_response)
        }.to raise_error(VSafe::RequestError)
      end
    end
  end

  context "#success?" do
    context "when success" do
      let(:httparty_response) { double(:response, success?: true, parsed_response: success_body) }

      it "returns true" do
        response = VSafe::Response.new(httparty_response)
        expect(response.success?).to eq(true)
      end
    end

    context "when fail" do
      let(:httparty_response) { double(:response, success?: true, parsed_response: fail_body) }

      it "returns false" do
        response = VSafe::Response.new(httparty_response)

        expect(response.success?).to eq(false)
      end
    end
  end

  context ".define_attribute_mapping" do
    class ::DummyWrapperClass
      attr_accessor :value

      def initialize(value)
        @value = value
      end
    end

    class DummyClassNoWrapper < VSafe::Response
      VSafe::Response.define_attribute_mapping("test1", "Test")
    end

    class DummyClassWithWrapper < VSafe::Response
      VSafe::Response.define_attribute_mapping("test2", "Test", DummyWrapperClass)
    end

    let(:attribute_name) { "test" }
    let(:response_attribute_name) { "Test" }
    let(:attribute_value) { "abc" }
    let(:success_body) {
      {
        "ResponseCode" => "0",
        "ResponseText" => "Success",
        response_attribute_name => attribute_value
      }
    }
    let(:httparty_response) { double(:response, success?: true, parsed_response: success_body) }

    context "when there is no wrapper" do
      it "returns attribute value" do
        response = DummyClassNoWrapper.new(httparty_response)

        expect(response.test1).to eq(attribute_value)
      end
    end

    context "when there is wrapper" do
      it "returns attribute value" do
        response = DummyClassWithWrapper.new(httparty_response)

        test_result = response.test2

        expect(test_result.is_a?(DummyWrapperClass)).to eq(true)
        expect(test_result.value).to eq(attribute_value)
      end
    end
  end

  context "#to_hash" do
    let(:httparty_response) { double(:response, success?: true, parsed_response: success_body) }

    it "returns parsed_response" do
      response = VSafe::Response.new(httparty_response)

      expect(response.to_hash).to eq(success_body)
    end
  end
end
