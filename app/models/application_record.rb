# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def graphql_errors
    errors.map do |attribute, message|
      {
        message: message,
        path: ["attributes", attribute.to_s.camelize(:lower)],
        extensions: { code: Errors::BaseError::ERROR_CODES.fetch(:user_error) },
      }
    end
  end
end
