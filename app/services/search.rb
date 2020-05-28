# frozen_string_literal: true

class Search
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def call
    PgSearch
      .multisearch(query)
      .map(&:searchable)
  end
end
