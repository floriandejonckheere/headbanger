# frozen_string_literal: true

module ErrorMatcher
  RSpec::Matchers.define :have_errors do |count|
    match do |response|
      errors = JSON
        .parse(response.body)
        .deep_symbolize_keys[:errors]

      @actual = Array(errors)

      @expected = count || 1

      expect(@actual).to eq @expected
    end

    failure_message do |_response|
      "expected response to have #{@expected} errors, but it had #{@actual.count} errors: #{@actual}"
    end
  end

  RSpec::Matchers.define :have_error_codes do |codes, *_args|
    match do |response|
      @actual = JSON
        .parse(response.body)
        .deep_symbolize_keys[:errors]
        &.flat_map { |e| e.dig(:extensions, :code) }

      Array(codes).each { |code| expect(@actual).to include code }
    end

    failure_message do |_response|
      "expected response to have error codes #{Array(codes).join(', ')}, but was #{Array(@actual).join(', ')}"
    end
  end
end
