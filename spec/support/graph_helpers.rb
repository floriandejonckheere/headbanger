# frozen_string_literal: true

module GraphHelpers
  def graph_artist(metal_archives_key)
    Graph::Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def graph_group(metal_archives_key)
    Graph::Group.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def graph_release(metal_archives_key)
    Graph::Release.find_or_initialize_by(metal_archives_key: metal_archives_key)
  end

  def graph_country(code)
    Graph::Country.find_or_initialize_by(code: code)
  end
end
