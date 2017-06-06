# frozen_string_literal: true

module Graph
  ##
  # Headbanger data aggregation framework
  #
  class AggregationService
    include Sidekiq::Worker

    def perform
      [GroupService, ArtistService].each do |service|
        service.enumerate.each do |resource|
          service.perform_async resource.id
        end
      end
    end
  end
end
