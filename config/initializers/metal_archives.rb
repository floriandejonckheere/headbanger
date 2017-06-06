# frozen_string_literal: true

MetalArchives.configure do |c|
  # Application identity (required)
  c.app_name = 'Headbanger'
  c.app_version = Headbanger::VERSION
  c.app_contact = ENV['MAILER_SENDER']

  # Metal Archives endpoint (optional, overrides default)
  # c.endpoint = 'http://ma.headbang.re/'

  # Request throttling (optional, overrides defaults)
  # c.request_rate = 1
  # c.request_timeout = 3

  # Custom cache size per object class (optional, overrides defaults)
  # c.cache_size = 100

  # Custom logger (optional)
  # c.logger = Logger.new File.new('metal_archives.log')
end
