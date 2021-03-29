# frozen_string_literal: true

register("config") do
  Headbanger::Config.new
end

register("artists.sync") do |model, **options|
  Artists::Sync.new(model, **options)
end

register("artists.source") do |**args|
  Artists::Source.new(**args)
end

register("artists.metal_archives") do |metal_archives_key|
  Artists::MetalArchives.new(metal_archives_key)
end

register("artists.musicbrainz") do |musicbrainz_key|
  Artists::MusicBrainz.new(musicbrainz_key)
end

register("groups.sync") do |model, **options|
  Groups::Sync.new(model, **options)
end

register("groups.source") do |**args|
  Groups::Source.new(**args)
end

register("groups.metal_archives") do |metal_archives_key|
  Groups::MetalArchives.new(metal_archives_key)
end

register("groups.musicbrainz") do |musicbrainz_key|
  Groups::MusicBrainz.new(musicbrainz_key)
end
