# frozen_string_literal: true

##
# Headbanger data aggregation framework
#
class AggregationService
  include Sidekiq::Worker

  def perform
    [GroupService, ArtistService].each do |service|
      service.source_model.all.each do |resource|
        service.perform_async resource.id
      end
    end
  end
end
