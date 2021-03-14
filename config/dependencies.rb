# frozen_string_literal: true

register("config") do
  Headbanger::Config.new
end

register("sync") do |model|
  Sync.new(model)
end
