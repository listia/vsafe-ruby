require "spec_helper"
require "vsafe/responses/get_session_tags"

RSpec.describe VSafe::Responses::GetSessionTags do
  let(:org_id) { "test_org_id" }
  let(:web_session_id) { "test_web_session_id" }
  let(:success_body) {
    {
      "OrgID" => org_id,
      "WebSessionID" => web_session_id
    }
  }
  let(:http_response) { double(:response, success?: true, parsed_response: success_body) }
  let(:response) { VSafe::Responses::GetSessionTags.new(http_response) }

  context "#org_id" do
    it "returns value" do
      expect(response.org_id).to eq(org_id)
    end
  end

  context "#web_session_id" do
    it "returns value" do
      expect(response.web_session_id).to eq(web_session_id)
    end
  end
end
