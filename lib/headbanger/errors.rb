module Headbanger
  ##
  # Generic error
  #
  class Error < StandardError; end

  ##
  # Functionality not implemented (yet)
  #
  class NotImplementedError < Error; end

  ##
  # Incorrect object type
  #
  class IncorrectTypeError < Error; end

  ##
  # Unable to generate human readable id
  #
  class NoSlugAvailableError < Error; end
end
