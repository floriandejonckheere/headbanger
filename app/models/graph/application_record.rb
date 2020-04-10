# frozen_string_literal: true

module Graph
  class ApplicationRecord
    include Neo4j::ActiveNode
    include Neo4j::Timestamps
  end
end
