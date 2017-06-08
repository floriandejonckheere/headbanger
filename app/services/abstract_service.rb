# frozen_string_literal: true

##
# Headbanger data aggregation framework (single datanode)
#
class AbstractService
  include Sidekiq::Worker

  attr_reader :instance

  ##
  # Sidekiq entry point
  #
  def perform(metal_archives_key)
    raise Headbanger::NoKeyError unless metal_archives_key

    debug 'Starting update'
    @instance = graph_model.find_or_initialize_by :metal_archives_key => metal_archives_key

    debug 'Fresh instance' if @instance.fresh?
    return if @instance.fresh?

    Neo4j::ActiveBase.run_transaction do |tx|
      begin
        debug 'Stale instance'

        source_instance
        update_attributes
        update_associations

        @instance.save
      rescue => e
        tx.mark_failed
        raise e
      end
    end
  end

  protected

  ##
  # Source data model
  #
  def source_model; end

  ##
  # Returns lazy Enumerable collection over all objects
  #
  def enumerate; end

  ##
  # Update attributes
  #
  def update_attributes; end

  ##
  # Update associations
  #
  def update_associations; end

  ##
  # Sanitize string
  #
  def sanitize(string)
    ActionView::Base.full_sanitizer.sanitize string
  end

  ##
  # Format log message
  #
  def format(msg)
    "[#{graph_model}] [#{@instance&.metal_archives_key}] #{msg}"
  end

  %i[debug warn info error].each do |level|
    define_method(level.to_s) { |msg| logger.send level, format(msg) }
  end

  private

  ##
  # Domain graph model
  #
  def graph_model
    self.class.to_s.chomp('Service').constantize
  end

  def source_instance
    # Find MA instance
    @metal_archives = source_model.find! @instance.metal_archives_key

    # Try to find musicbrainz instance
    find_musicbrainz_instance
  end

  def find_musicbrainz_instance
    query = ActiveMusicbrainz::Model::Artist.joins(:area)
              .joins(:type)
              .where 'artist.name ILIKE :name', :name => @metal_archives.name

    if query.one?
      @musicbrainz = query.first
      # raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Person' # or 'Group'

      return
    end

    query = query.where 'area.name ILIKE :name', :name => @metal_archives.country.name

    if query.one?
      @musicbrainz = query.first
      # raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Person' # or 'Group'

      return
    end

    query.each do |band|
      next if band.type.name == 'Person'

      band.urls.each do |url|
        if url.url.match?(%r{(http:\/\/)?(www.)?metal-archives.com})
          metal_archives_key = url.url.split('/').last
          break
        end
      end

      next unless metal_archives_key == @instance.metal_archives_key
      @instance.musicbrainz_key = @musicbrainz.gid

      @musicbrainz = band
      break
    end

    raise Headbanger::NoKeyError unless @musicbrainz
  end
end
