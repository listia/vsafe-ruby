require "spec_helper"
require "vsafe"

describe VSafe do
  context ".configure" do
    it "yields config" do
      VSafe.configure do |config|
        expect(config).to be_an_instance_of(VSafe::Config)
      end
    end
  end
end
