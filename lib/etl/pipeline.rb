# frozen_string_literal: true

module ETL
  class Pipeline
    class_attribute :steps

    def initialize
      self.steps = []

      setup
    end

    def setup
      raise NotImplementedError
    end

    def run(enumerable)
      Rails.logger.info "[#{self.class.name}] Running pipeline on #{enumerable}"

      enumerable.each { |data| step(data) }

      Rails.logger.info "[#{self.class.name}] Pipeline finished!"
    end

    def step(data)
      # Accumulate value through steps
      steps
        .inject(data) do |memo, step|
        Rails.logger.info "[#{self.class.name}] Running step #{step.class.name} on #{memo}"

        step.run(memo)
      rescue StandardError => e
        # TODO: reschedule job
        Rails.logger.info "[#{self.class.name}] Pipeline error on step #{step.class.name}: #{e.message}"
        Rails.logger.info e.backtrace.first(10)

        break
      end
    end
  end
end
