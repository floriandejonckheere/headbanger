# frozen_string_literal: true

module Errors
  class BaseError < GraphQL::ExecutionError
    ERROR_CODES = {
      user_error: "USER_ERROR",
      authentication_error: "AUTHENTICATION_ERROR",
      authorization_error: "AUTHORIZATION_ERROR",
      internal_server_error: "INTERNAL_SERVER_ERROR",
    }.freeze
  end
end
