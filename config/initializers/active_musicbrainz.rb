# frozen_string_literal: true

begin
  ActiveMusicbrainz::Model::Base.establish_connection :musicbrainz
  ActiveMusicbrainz.init
rescue StandardError => e
  # Reraise exception if not in development
  raise e unless Rails.env.development?

  Rails.logger.warn "Connection to MusicBrainz database NOT established"
end
