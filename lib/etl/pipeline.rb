# frozen_string_literal: true

module ETL
  class Pipeline
    class_attribute :steps

    self.steps = []

    def run(data)
      # Iterate over input
      data.each do |entry|
        # Accumulate value through steps
        steps
          .inject(entry) do |memo, step|
          step.run(memo)
        rescue StandardError
          # TODO: error handling
          break
        end
      end

      nil
    end

    def self.step(&block)
      steps << block.call
    end
  end
end
