class AppController < ApplicationController
  layout 'session', :only => [:terms_of_service, :privacy_policy]

  # Routes
  def discover
    @a_flame_to_the_ground_beneath = Graph::Release.find_by! :musicbrainz_key => '4c448bb7-d79f-4cc9-b25a-7e9752eaa562'
  end

  def terms_of_service; end
  def privacy_policy; end
end
