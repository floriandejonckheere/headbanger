# frozen_string_literal: true
namespace :neo4j do
  desc 'Populates the database with sample data'
  task :populate => :environment do
    Neo4j::ActiveBase.run_transaction do |tx|
      begin
        attrs = {
          :musicbrainz_key => '40e1c1e4-4972-4344-b1a8-7a03ba987da1',
          :year_formed => Date.new(1998),
          :status => :on_hold
        }
        lost_horizon = Graph::Group.new attrs

        lost_horizon.names << Graph::Name.new(:name => 'Lost Horizon', :primary => true)
        lost_horizon.country = Graph::Country.new(:country => 'SE')
        lost_horizon.lyrical_themes << Graph::LyricalTheme.new(:name => 'Self-empowerment')
        lost_horizon.lyrical_themes << Graph::LyricalTheme.new(:name => 'Self-confidence')
        lost_horizon.lyrical_themes << Graph::LyricalTheme.new(:name => 'Truth')
        lost_horizon.genres << Graph::Genre.new(:name => 'Power Metal')

        attrs = {
          :musicbrainz_key => '84943202-ea8b-3124-a7ac-36fa8d7c8306',
          :title => 'Awakening The World',
          :release_date => Date.new(2001)
        }
        awakening_the_world = Graph::Release.new attrs

        attrs = {
          :musicbrainz_key => '4c448bb7-d79f-4cc9-b25a-7e9752eaa562',
          :title => 'A Flame to the Ground Beneath',
          :release_date => Date.new(2003)
        }
        a_flame_to_the_ground_beneath = Graph::Release.new attrs

        lost_horizon.releases << awakening_the_world
        lost_horizon.releases << a_flame_to_the_ground_beneath

        lost_horizon.save
      rescue => e
        Rails.logger.error e.message
        tx.mark_failed
      end
    end
  end
end
