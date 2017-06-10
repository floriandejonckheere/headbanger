# frozen_string_literal: true

##
# Data aggregation framework
#
class DataNodeService
  include Sidekiq::Worker

  ##
  # Sidekiq entry point
  #
  def perform(class_sym, metal_archives_key)
    builder = "#{class_sym.to_s.capitalize}Builder".constantize.new
    builder.metal_archives_key = metal_archives_key

    builder.find_or_initialize

    return true if builder.instance&.fresh?

    builder.update_sources

    Neo4j::ActiveBase.run_transaction do |tx|
      builder.update_attributes
      builder.update_associations

      builder.instance.save
    end
  end
end
