# frozen_string_literal: true

Raven.configure do |config|
  config.async = ->(event) { SentryJob.perform_later(event) }
  config.release = Headbanger::Version::STRING
  config.tags = { instance: ENV.fetch("INSTANCE", "headbanger") }
end
