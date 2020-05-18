# frozen_string_literal: true

class Scrub
  def call
    ActiveRecord::Base.transaction do
      scrubables.each(&:sync!)
    end
  end

  def scrubables
    @scrubables ||= Artist
      .order(synced_at: :asc)
      .where("synced_at < ?", Headbanger.config.data_expires_in.ago)
      .limit(Headbanger.config.sync_limit)
  end
end
