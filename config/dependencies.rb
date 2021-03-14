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

register("groups.sync") do |model|
  Groups::Sync.new(model)
end

register("groups.source") do |**args|
  Groups::Source.new(**args)
end
