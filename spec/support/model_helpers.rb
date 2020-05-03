# frozen_string_literal: true

module ModelHelpers
  def find_artist(metal_archives_key)
    Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_group(metal_archives_key)
    Group.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_release(metal_archives_key)
    Release.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_theme(name)
    Theme.find_or_initialize_by(name: name)
  end

  def find_genre(name)
    Genre.find_or_initialize_by(name: name)
  end
end
