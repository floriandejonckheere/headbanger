# frozen_string_literal: true

module Headbanger
  ##
  # Transient error, does not require user intervention
  #
  class TransientError < Error
    def persistent?
      false
    end

    def transient?
      true
    end
  end
end
