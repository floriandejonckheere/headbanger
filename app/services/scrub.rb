# frozen_string_literal: true

class Scrub
  def call
    ActiveRecord::Base.transaction do
      scrubables
        .map { |model| Headbanger.container.resolve("sync", model) }
        .each(&:call)
    end
  end

  def scrubables
    @scrubables ||= Artist
      .order(synced_at: :asc)
      .where("synced_at < ?", Headbanger.config.data_expires_in.ago)
      .limit(Headbanger.config.sync_limit)
  end
end
