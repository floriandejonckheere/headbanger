# frozen_string_literal: true

require Rails.root.join("lib/headbanger/app.rb")
require Rails.root.join("lib/headbanger/version.rb")

MetalArchives.configure do |c|
  ## Application identity (required)
  c.app_name    = Headbanger::App::NAME
  c.app_version = Headbanger::Version::STRING
  c.app_contact = Headbanger::App::CONTACT

  ## Custom cache size per object class (optional, overrides defaults)
  # c.cache_size = 100

  ## Metal Archives endpoint (optional, overrides default)
  c.endpoint = ENV.fetch("MA_ENDPOINT", "http://web:81/")
  c.endpoint_user = ENV.fetch("MA_ENDPOINT_USER", nil)
  c.endpoint_password = ENV.fetch("MA_ENDPOINT_PASSWORD", nil)

  ## Custom logger (optional)
  c.logger = Logger.new File.open("/dev/null")
  c.logger.level = Logger::ERROR
end
