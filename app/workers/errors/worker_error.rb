module Errors
  ##
  # Generic worker error
  #
  class WorkerError < StandardError; end

  ##
  # Functionality not implemented (yet)
  #
  class NotImplementedError < WorkerError; end

  ##
  # Incorrect object type
  #
  class IncorrectTypeError < WorkerError; end
end
