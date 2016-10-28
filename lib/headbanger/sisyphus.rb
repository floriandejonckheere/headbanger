require_relative 'sisyphus/errors'

module Headbanger
module Sisyphus
  class << self
    attr_accessor :logger
  end

  @logger = Object.new

  def @logger.method_missing(name, *args, &block)
    Rails.logger.tagged('sisyphus') { |l| l.send name, *args }
  end
end
end
