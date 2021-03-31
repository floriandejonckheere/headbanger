# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV["RAILS_APP_SENTRY_DSN"]
  config.release = Headbanger::Version::STRING
  config.send_default_pii = true
end
