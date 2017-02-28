module Headbanger
  ##
  # Generic error
  #
  class Error < StandardError; end

  ##
  # Persistent error, requires user intervention
  #
  class PersistentError < Error
    def persistent?; true; end
    def transient?; false; end
  end

  ##
  # Transient error, does not require user intervention
  #
  class TransientError < Error
    def persistent?; false; end
    def transient?; true; end
  end

  ##
  # Functionality not implemented (yet)
  #
  class NotImplementedError < PersistentError; end

  ##
  # No determinant available (usually :musicbrainz_key)
  #
  class NoDeterminantError < PersistentError; end

  ##
  # Incorrect object type
  #
  class IncorrectTypeError < PersistentError; end

  ##
  # Unable to generate human readable id
  #
  class NoSlugAvailableError < PersistentError; end
end
