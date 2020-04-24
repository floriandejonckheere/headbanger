# frozen_string_literal: true

def transaction
  ActiveRecord::Base.transaction do
    yield
  end
end

def neo4j_transaction
  Neo4j::ActiveBase.run_transaction do |tx|
    yield
  rescue StandardError => e
    tx.mark_failed
    raise e
  end
end
