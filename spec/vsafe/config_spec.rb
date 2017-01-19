require "spec_helper"
require "vsafe/config"

RSpec.describe VSafe::Config do
  let (:config) { VSafe::Config.new }

  describe ".new" do
    it "sets default configs" do
      expect(config.sandbox).to eq(true)
      expect(config.request_timeout).to be_a(Fixnum)
      expect(config.url).not_to be_empty
    end
  end

  describe "#url" do
    context "sandbox is true" do
      it "uses default sandbox_url" do
        expect(config.url).to eq(VSafe::Config::DEFAULT_SANDBOX_URL)
      end

      it "uses custom sandbox_url when sandbox" do
        config.sandbox_url = "https://www.google.com"
        expect(config.url).to eq("https://www.google.com")
      end
    end

    context "sandbox is not true" do
      before do
        config.sandbox = false
      end

      it "uses default production_url when not sandbox" do
        expect(config.url).to eq(VSafe::Config::DEFAULT_PRODUCTION_URL)
      end

      it "uses custom production_url when not sandbox" do
        config.production_url = "https://www.google.com"
        expect(config.url).to eq("https://www.google.com")
      end
    end
  end

  describe "#jsonp_url" do
    context "sandbox is true" do
      it "uses default sandbox_url" do
        expect(config.jsonp_url).to eq(VSafe::Config::DEFAULT_SANDBOX_JSONP_URL)
      end

      it "uses custom sandbox_jsonp_url when set" do
        config.sandbox_jsonp_url = "https://www.googlesandbox.com"
        expect(config.jsonp_url).to eq("https://www.googlesandbox.com")
      end
    end

    context "sandbox is not true" do
      before do
        config.sandbox = false
      end

      it "uses custom production_url when not sandbox" do
        config.production_jsonp_url = "https://www.googlesandbox.com"
        expect(config.jsonp_url).to eq("https://www.googlesandbox.com")
      end
    end
  end

  describe "#jsonp_url" do
    context "sandbox is true" do
      it "uses default sandbox_url" do
        expect(config.jsonp_url).to eq(VSafe::Config::DEFAULT_SANDBOX_JSONP_URL)
      end

      it "uses custom sandbox_jsonp_url when set" do
        config.sandbox_jsonp_url = "https://www.googlesandbox.com"
        expect(config.jsonp_url).to eq("https://www.googlesandbox.com")
      end
    end
  end
end
