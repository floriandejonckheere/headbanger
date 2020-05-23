# frozen_string_literal: true

module Queries
  class ApplicationQuery < GraphQL::Schema::Resolver
    extend GraphQL::Schema::Member::HasFields
    extend GraphQL::Schema::Resolver::HasPayloadType

    class << self
      # Override this method to handle legacy-style usages of `MyMutation.field`
      def field(*args, &block)
        return super unless args.empty?

        raise ArgumentError, "#{name}.field is used for adding fields to this mutation. " \
                             "Use `mutation: #{name}` to attach this mutation instead."
      end

      def visible?(_context)
        true
      end
    end
  end
end
