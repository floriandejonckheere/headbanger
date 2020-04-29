# frozen_string_literal: true

RSpec.describe User do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_inclusion_of(:country).in_array ISO3166::Country.codes }
end
