# frozen_string_literal: true

module Errors
  class UserError < BaseError
    def to_h
      super.merge extensions: { code: ERROR_CODES.fetch(:user_error) }
    end
  end
end
