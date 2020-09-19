# frozen_string_literal: true

module BuilderHelpers
  def find_or_initialize_artist(metal_archives_key)
    Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_or_initialize_group(metal_archives_key)
    Group.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_or_initialize_release(metal_archives_key)
    Release.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def find_or_initialize_theme(name)
    Theme.find_or_initialize_by(name: name)
  end

  def find_or_initialize_genre(name)
    Genre.find_or_initialize_by(name: name)
  end
end
