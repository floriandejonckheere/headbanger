# frozen_string_literal: true

module Steps
  class Wrap < ETL::Step
    attr_reader :type

    def initialize(type)
      super()

      @type = type
    end

    def run(data)
      data.merge(type: type)
    end
  end
end
