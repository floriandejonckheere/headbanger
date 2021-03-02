# frozen_string_literal: true

module Sinks
  class Database < ETL::Sink
    def run(data)
      data
        .fetch(:type)
        .camelize
        .constantize
        .find_or_initialize_by(metal_archives_key: data.fetch(:metal_archives_key))
        .update!(synced_at: Time.zone.now, **data.fetch(:attributes))
    end
  end
end
