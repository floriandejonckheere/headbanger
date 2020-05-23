# frozen_string_literal: true

module Interfaces
  module BaseInterface
    include GraphQL::Schema::Interface

    field_class Types::BaseField
  end
end
