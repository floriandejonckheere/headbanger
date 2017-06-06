# frozen_string_literal: true

module Headbanger
  ##
  # Generic error
  #
  ##
  # Persistent error, requires user intervention
  #
  class PersistentError < Error
    def persistent?
      true
    end

    def transient?
      false
    end
  end
end
