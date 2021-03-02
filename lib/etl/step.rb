# frozen_string_literal: true

module ETL
  class Step
    def run(data)
      raise NotImplementedError
    end
  end
end
