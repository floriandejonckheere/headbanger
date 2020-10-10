# frozen_string_literal: true

module Errors
  class InternalServerError < BaseError
    attr_reader :error

    def initialize(error)
      super(error.message)

      @error = error
    end

    def to_h
      super.merge message: error.message,
                  backtrace: error.backtrace,
                  extensions: { code: ERROR_CODES.fetch(:internal_server_error) }
    end
  end
end
