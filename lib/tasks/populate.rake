# frozen_string_literal: true

namespace :neo4j do
  desc "Populates the database with sample data"
  task populate: :environment do
    def group(id)
      DataNodeService.new.perform :group, id
    end

    def artist(id)
      DataNodeService.new.perform :artist, id
    end

    ##
    # Groups
    #
    group 122_302 # Pathfinder
    group 32 # Rhapsody of Fire
    group 3_540_382_043 # Twilight Force
    group 8051        # Fairyland
    group 2000        # Dragonland
    group 377         # Lost Horizon
    group 3_540_348_143 # Luca Turilli's Rhapsody

    ##
    # Artists
    #
    artist 60_908 # Alberto Rionda
    artist 2001 # Luca Turilli
    artist 35_049      # Glen Metal
    artist 17_722      # Mathias Blad
    artist 673        # Hansi Kursch
    artist 2291       # Kai Hansen
  end
end
