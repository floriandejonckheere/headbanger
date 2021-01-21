# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = ENV["RAILS_APP_SENTRY_DSN"]
  config.async = ->(event) { SentryJob.perform_later(event) }
  config.release = Headbanger::Version::STRING
  config.tags = { instance: ENV.fetch("VUE_APP_INSTANCE", "development") }
end
