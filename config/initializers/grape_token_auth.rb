GrapeTokenAuth.setup! do |config|
  ## The time span that GTA tokens are valid for
  # config.token_lifespan = 2.weeks
  config.token_lifespan = 2.days

  ## The timeframe in which a subsequent requests
  ## are considered "batch" requests
  # config.batch_request_buffer_throttle = 5.seconds

  ## Whether new auth headers / tokens are created on each request
  # config.change_headers_on_each_request = true

  ## Scope to class mappings
  config.mappings = { user: User }

  ## Array of urls that are allowed to be redirected
  ## to after authentication requests
  # config.redirect_whitelist =

  ## Hash where key is the scope and value is array of
  ## attributes that are permitted to be set on a resource
  # config.param_white_list =

  ## Array of attributes that can be used to find a resource
  # config.authentication_keys = [:email]

  ## URL prefix where omniauth and related callbacks are
  ## mounted, this will become the OmniAuth::config.path_prefix
  # config.omniauth_prefix = '/omniauth'

  ## When set to true, the default serialization blacklist
  ## is not applied, only use this when you need to
  ## serialize an attribute that is in the default list
  # config.ignore_default_serialization_blacklist = false

  ## list of attributes that should be ignored
  ## when serializing an object
  # config.additional_serialization_blacklist = []

  ## The "from" email for authentication emails
  # config.from_address =

  ## URL hash for creating urls in auth emails
  # config.default_url_options = {}

  ## Mailer class used to send emails
  # config.mailer = SMTPMailer

  ## Default redirect url if not provided in password reset params
  # config.default_password_reset_url =

  ## SMTP configuration hash for SMTP mailer
  # config.smtp_configuration = {}

  ## Random Hex String used to salt key generation
  config.secret = Rails.application.secrets[:secret_key_base]

  ## Default digest method
  # config.digest = 'SHA256'

  ## Message classes that are used to create emails
  # config.messages = GrapeTokenAuth::Mail::DEFAULT_MESSAGES
end
