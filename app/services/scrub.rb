# frozen_string_literal: true

class Scrub
  def call
    ActiveRecord::Base.transaction do
      scrubables
        .map { |model| Headbanger.container.resolve("artists.sync", model) }
        .each(&:call)
    end
  end

  def scrubables
    Artist
      .where(synced_at: ..Headbanger.config.data_expires_in.ago)
      .order(synced_at: :asc)
      .limit(Headbanger.config.sync_limit)
  end
end
