# frozen_string_literal: true

require Rails.root.join("lib/headbanger/app.rb")
require Rails.root.join("lib/headbanger/version.rb")

MetalArchives.configure do |c|
  ## Application identity (required)
  c.app_name    = Headbanger::App::NAME
  c.app_version = Headbanger::Version::STRING
  c.app_contact = Headbanger::App::CONTACT

  ## Request throttling (optional, overrides defaults)
  c.request_rate = 10
  c.request_timeout = 5

  ## Connect additional Faraday middleware
  # c.middleware = [MyMiddleware, MyOtherMiddleware]

  ## Custom cache size per object class (optional, overrides defaults)
  c.cache_size = 100

  ## Metal Archives endpoint (optional, overrides default)
  c.endpoint = "http://web:81/"

  ## Custom logger (optional)
  c.logger = Logger.new File.open("/dev/null")
  c.logger.level = Logger::ERROR
end
