$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "vsafe"
require "webmock/rspec"
require "byebug"

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Disable the should syntax compeletely; we use the expect syntax only.
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
