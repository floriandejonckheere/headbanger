# frozen_string_literal: true

register("config") do
  Headbanger::Config.new
end

register("artists.sync") do |model|
  Artists::Sync.new(model)
end

register("artists.source") do |**args|
  Artists::Source.new(**args)
end
