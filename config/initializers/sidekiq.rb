Sidekiq.configure_server do |config|
  config.redis = { url: "unix://#{Rails.root}/tmp/sockets/redis.sock", :namespace => 'headbanger' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "unix://#{Rails.root}/tmp/sockets/redis.sock", :namespace => 'headbanger' }
end
