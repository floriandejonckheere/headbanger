# frozen_string_literal: true

module Errors
  class AuthorizationError < BaseError
    def to_h
      super.merge extensions: { code: ERROR_CODES.fetch(:authorization_error) }
    end
  end
end
