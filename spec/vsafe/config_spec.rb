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

    it "allows setting configs" do
      config = VSafe::Config.new(
        sandbox: false,
        account_name: "account",
        password: "password",
        request_timeout: 100,
        url: "url"
      )

      expect(config.sandbox).to eq(false)
      expect(config.account_name).to eq("account")
      expect(config.password).to eq("password")
      expect(config.request_timeout).to eq(100)
      expect(config.url).to eq("url")
    end
  end
end
