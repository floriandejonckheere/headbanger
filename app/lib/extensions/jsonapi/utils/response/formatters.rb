# frozen_string_literal: true

module Extensions
  module JSONAPI
    module Utils
      module Response
        module Formatters
          # Turn an AR or Hash object into a JSONAPI::Resource one.
          #
          # @param records [ActiveRecord::Relation, Hash, Array<Hash>]
          #   Object to be instantiated as a JSONAPI::Resource one.
          #   e.g.: User.first, { data: { id: 1, first_name: 'Tiago' } }
          #
          # @option options [JSONAPI::Resource] resource: it tells which resource
          #   class to be used rather than use an infered one (default behaviour)
          #
          # @return [JSONAPI::Resource]
          #
          # @api private
          def turn_into_resource(record, options)
            if options[:resource]
              options[:resource].to_s.constantize.new(record, context)
            else
              # This line was modified to infer resource class from record instead of request
              "#{record.class}Resource".constantize.new(record, context)
            end
          end
        end
      end
    end
  end
end

JSONAPI::Utils::Response.include Extensions::JSONAPI::Utils::Response::Formatters
