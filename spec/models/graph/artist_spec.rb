# frozen_string_literal: true

require 'rails_helper'

describe Graph::Artist do
  it { is_expected.to respond_to :gender }
  it { is_expected.to respond_to :date_of_birth }
  it { is_expected.to respond_to :date_of_death }
  it { is_expected.to respond_to :biography }

  it { is_expected.to respond_to :country }
  it { is_expected.to respond_to :names }
  it { is_expected.to respond_to :releases }

  it 'is valid with attributes' do
    artist = build :artist

    expect(artist).to be_valid
  end
end
