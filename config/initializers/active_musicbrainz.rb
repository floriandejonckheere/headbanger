begin
  ActiveMusicbrainz::Model::Base.establish_connection :musicbrainz
  ActiveMusicbrainz.init
rescue => e
  # Reraise exception if not in development
  if Rails.env.development?
    Rails.logger.warn 'Connection to MusicBrainz database NOT established'
  else
    raise e
  end
end
