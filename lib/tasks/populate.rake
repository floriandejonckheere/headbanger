# frozen_string_literal: true

namespace :neo4j do
  desc 'Populates the database with sample data'
  task :populate => :environment do
    Neo4j::ActiveBase.run_transaction do |tx|
      begin
        power_metal = Genre.create(:name => 'Power Metal')
        symphonic_power_metal = Genre.create(:name => 'Symphonic Power Metal')
        power_metal.subgenres << symphonic_power_metal

        ##
        # Lost Horizon
        #
        attrs = {
          :musicbrainz_key => '40e1c1e4-4972-4344-b1a8-7a03ba987da1',
          :year_formed => Date.new(1998),
          :status => :on_hold
        }
        lost_horizon = Group.new attrs

        lost_horizon.names << Name.new(:name => 'Lost Horizon', :primary => true)
        lost_horizon.country = Country.new(:country => 'SE')
        lost_horizon.lyrical_themes << LyricalTheme.new(:name => 'Self-empowerment')
        lost_horizon.lyrical_themes << LyricalTheme.new(:name => 'Self-confidence')
        lost_horizon.lyrical_themes << LyricalTheme.new(:name => 'Truth')
        lost_horizon.genres << Genre.find_by!(:name => 'Power Metal')

        attrs = {
          :musicbrainz_key => '84943202-ea8b-3124-a7ac-36fa8d7c8306',
          :title => 'Awakening The World',
          :release_date => Date.new(2001)
        }
        awakening_the_world = Release.new attrs

        attrs = {
          :musicbrainz_key => '4c448bb7-d79f-4cc9-b25a-7e9752eaa562',
          :title => 'A Flame to the Ground Beneath',
          :release_date => Date.new(2003)
        }
        a_flame_to_the_ground_beneath = Release.new attrs

        lost_horizon.releases << awakening_the_world
        lost_horizon.releases << a_flame_to_the_ground_beneath

        lost_horizon.save!

        ##
        # Pathfinder
        #
        attrs = {
          :musicbrainz_key => 'e3f600d4-82cc-45a2-bc89-ebc25ed57719',
          :year_formed => Date.new(2006),
          :status => :active
        }
        pathfinder = Group.new attrs

        pathfinder.names << Name.new(:name => 'Pathfinder', :primary => true)
        pathfinder.country = Country.new(:country => 'PL')
        pathfinder.lyrical_themes << LyricalTheme.new(:name => 'Fantasy')
        pathfinder.lyrical_themes << LyricalTheme.new(:name => 'Battles')
        pathfinder.lyrical_themes << LyricalTheme.new(:name => 'Glory')
        pathfinder.lyrical_themes << LyricalTheme.new(:name => 'The Four Elements')
        pathfinder.lyrical_themes << LyricalTheme.new(:name => 'Metal')
        pathfinder.genres << Genre.find_by!(:name => 'Power Metal')
        pathfinder.genres << Genre.find_by!(:name => 'Symphonic Power Metal')

        attrs = {
          :musicbrainz_key => 'b31abbae-8aff-4bb3-8c22-030ca2ab8076',
          :title => 'Beyond the Space, Beyond the Time',
          :release_date => Date.new(2010)
        }
        beyond_the_space = Release.new attrs

        attrs = {
          :musicbrainz_key => '488f334b-4409-4139-9e40-d5701568aa85',
          :title => 'Fifth Element',
          :release_date => Date.new(2012)
        }
        fifth_element = Release.new attrs

        pathfinder.releases << beyond_the_space
        pathfinder.releases << fifth_element

        pathfinder.save!
      rescue => e
        Rails.logger.error e.message
        tx.mark_failed
      end
    end
  end
end
