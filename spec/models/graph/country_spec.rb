# frozen_string_literal: true

RSpec.describe Graph::Country do
  it { is_expected.to define_property :code, :String }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to define_constraint :code, :unique }
  it { is_expected.to validate_inclusion_of(:code).in_array(ISO3166::Country.codes) }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }
end