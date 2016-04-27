require "vsafe/response"
require "vsafe/client"
require "vsafe/config"

module VSafe
  def self.configure(&block)
    @config = Config.new

    yield @config

    nil
  end

  def self.config
    @config ||= Config.new
  end
end
