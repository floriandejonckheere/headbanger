# frozen_string_literal: true

module Headbanger
  class Config
    include Singleton

    class << self
      delegate_missing_to :instance
    end

    def data_expires_in
      @data_expires_in ||= ENV.fetch("HB_DATA_EXPIRES_IN", 7).to_i.days
    end

    def sync_limit
      @sync_limit ||= ENV.fetch("HB_SYNC_LIMIT", 5).to_i
    end

    def sync_interval
      @sync_interval ||= ENV.fetch("HB_SYNC_INTERVAL", 30).to_i
    end
  end
end
