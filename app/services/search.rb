# frozen_string_literal: true

class Search
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def call
    Group
      .where("name LIKE ?", "%#{query}%")
  end
end
