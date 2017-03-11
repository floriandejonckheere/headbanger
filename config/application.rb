require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
#require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require "action_mailer/railtie"
require 'action_view/railtie'
# require "action_cable/engine"
require "sprockets/railtie"
# require 'rails/test_unit/railtie'
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Headbanger
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)

    config.mailer = YAML.load_file(Rails.root.join('config', 'mailer.yml'))[Rails.env]
    config.action_mailer.default_url_options = {
        :host => config.mailer['default_host_host'] || 'localhost',
        :port => config.mailer['default_host_port'] || '80',
        :protocol => config.mailer['default_host_proto'] || 'http'
    }

    # Add bower_components to asset path
    config.assets.paths << Rails.root.join('vendor','assets','bower_components')
    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|woff2)$)
  end
end
