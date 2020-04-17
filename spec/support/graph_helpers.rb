# frozen_string_literal: true

module GraphHelpers
  def artist(metal_archives_key)
    Graph::Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def group(metal_archives_key)
    Graph::Group.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def release(metal_archives_key)
    Graph::Release.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def country(code)
    Graph::Country.find_or_initialize_by(code: code)
  end
end
