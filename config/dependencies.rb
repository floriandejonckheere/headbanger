# frozen_string_literal: true

register("config") do
  Headbanger::Config.new
end

register("sync_artist") do |model|
  Artists::Sync.new(model)
end
