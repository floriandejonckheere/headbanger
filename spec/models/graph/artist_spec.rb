require 'rails_helper'

describe Graph::Artist do
  it { is_expected.to respond_to :gid }
  it { is_expected.to respond_to :date_of_birth }
  it { is_expected.to respond_to :artist_names }
  it { is_expected.to respond_to :groups }

  describe FactoryGirl.build(:artist, :gid => nil) do
    it { is_expected.not_to be_valid }
  end

  describe FactoryGirl.create(:artist, :name_count => 2) do
    it { expect(subject.artist_names.count).to eq 2 }
  end
end
