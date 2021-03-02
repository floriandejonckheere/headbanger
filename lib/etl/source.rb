# frozen_string_literal: true

module ETL
  class Source
    attr_reader :data

    def initialize(**data)
      @data = data
    end

    delegate :each, to: :data
  end
end
