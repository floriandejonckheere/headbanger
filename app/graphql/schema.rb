# frozen_string_literal: true

class Schema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  # Restrict clients from asking too much data
  default_max_page_size 25

  def self.resolve_type(_abstract_type, object, _context)
    type_class = "::Types::#{object.class}Type".safe_constantize

    raise ArgumentError, "Cannot resolve type for class #{object.class.name}" if type_class.blank?

    type_class
  end

  def self.object_from_id(id, _context)
    return if id.blank?

    record_class_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)
    record_class = record_class_name.safe_constantize
    record_class&.find_by id: record_id
  end

  def self.id_from_object(object, _type, _context)
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  end

  def self.to_fragment_types
    fragments = execute("{ __schema { types { kind name possibleTypes { name } } } }")
      .to_h
      .dig("data", "__schema", "types")
      .select { |t| t["possibleTypes"] }

    JSON.pretty_generate({ __schema: { types: fragments } })
  end
end
