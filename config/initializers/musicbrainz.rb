MusicBrainz.configure do |c|
  # Application identity (required)
  c.app_name = Rails.application.config.api.name
  c.app_version = Headbanger::VERSION
  c.contact = Rails.application.config.api.contact

  # Cache config (optional)
  c.cache_path = '/tmp/musicbrainz-cache'
  c.perform_caching = true

  # Querying config (optional)
  c.query_interval = 1.2 # seconds
  c.tries_limit = 2
end
