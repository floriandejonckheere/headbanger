# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    class_attribute :authorization_record,
                    :authorization_query

    def self.authorize(record, query = pundit_query)
      self.authorization_record = record
      self.authorization_query = query
    end

    def self.pundit_query
      :"#{name.demodulize.underscore}?"
    end

    def authorized?(**inputs)
      return true unless self.class.authorization_record

      Pundit
        .authorize context[:current_resource],
                   inputs.fetch(self.class.authorization_record),
                   authorization_query

      true
    rescue Pundit::NotAuthorizedError => e
      raise Errors::AuthorizationError, e.message
    end
  end
end
