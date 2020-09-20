# frozen_string_literal: true

module ErrorMatcher
  RSpec::Matchers.define :have_errors do |codes, *_args|
    match do |response|
      @actual = JSON
        .parse(response.body)
        .deep_symbolize_keys[:errors]
        &.map { |e| e.key?(:extensions) ? e.dig(:extensions, :code) : e[:message] }

      if codes
        Array(codes).each { |code| expect(@actual).to include code }
      else
        expect(@actual).to be_any
      end
    end

    failure_message do |_response|
      "expected response to have error codes #{Array(codes).join(', ')}, but was #{Array(@actual).join(', ')}"
    end
  end
end
