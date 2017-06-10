# frozen_string_literal: true

MetalArchives.configure do |c|
  ## Application identity (required)
  c.app_name = 'Headbanger'
  c.app_version = Headbanger::VERSION
  c.app_contact = ENV['MAILER_SENDER']

  ## Request throttling (optional, overrides defaults)
  # c.request_rate = 1
  # c.request_timeout = 3

  ## Connect additional Faraday middleware
  # c.middleware = [MyMiddleware, MyOtherMiddleware]

  ## Custom cache size per object class (optional, overrides defaults)
  # c.cache_size = 100

  ## Metal Archives endpoint (optional, overrides default)
  c.endpoint = ENV['MA_ENDPOINT'] if ENV.key? 'MA_ENDPOINT'
  Rails.logger.info "Using #{c.endpoint || c.default_endpoint} as Metal Archives endpoint"

  ## Custom logger (optional)
  # c.logger = Logger.new File.new('metal_archives.log')

  ## Verbose output
  # c.debug = false
end
