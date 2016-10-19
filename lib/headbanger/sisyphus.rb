require_relative 'sisyphus/errors'

module Headbanger
module Sisyphus
  def logger
    Rails.application.config.logger.tagged 'sisyphus'
  end
end
end
