require "spec_helper"
require "vsafe/config"

RSpec.describe VSafe::Config do
  describe ".new" do
    it "sets default configs" do
      config = VSafe::Config.new

      expect(config.sandbox).to eq(true)
      expect(config.request_timeout).to be_a(Fixnum)
      expect(config.url).not_to be_empty
    end
  end
end
