require_relative 'sisyphus/errors'

module Headbanger
module Sisyphus
  class << self
    attr_accessor :logger
  end

  @logger = Logger.new Rails.root.join('log', 'sisyphus.log')
end
end
