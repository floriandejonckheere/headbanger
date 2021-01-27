# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def graphql_errors
    errors.map do |error|
      {
        message: error.full_message,
        path: ["attributes", error.attribute.to_s.camelize(:lower)],
        extensions: { code: Errors::BaseError::ERROR_CODES.fetch(:user_error) },
      }
    end
  end
end
