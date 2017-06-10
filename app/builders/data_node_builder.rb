# frozen_string_literal: true

##
# DataNode builder class
#
class DataNodeBuilder
  attr_accessor :metal_archives_key
  attr_reader :instance

  ##
  # Find or create object
  #
  def find_or_initialize; end

  ##
  # Find data sources
  #
  def update_sources; end

  ##
  # Update attributes
  #
  def update_attributes; end

  ##
  # Update associations
  #
  def update_associations; end

  protected

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
    "[#{self.class}] [#{metal_archives_key}] #{msg}"
  end

  %i[debug warn info error].each do |level|
    define_method(level.to_s) { |msg| logger.send level, format(msg) }
  end
end
