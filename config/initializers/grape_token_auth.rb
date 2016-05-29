GrapeTokenAuth.setup! do |config|
  config.mappings = { user: User }
  config.secret = Rails.application.secrets[:secret_key_base]
end
