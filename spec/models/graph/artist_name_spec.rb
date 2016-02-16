require 'rails_helper'

describe Graph::ArtistName do
  it { is_expected.to respond_to :name }

  describe FactoryGirl.build(:artist_name, :name => nil) do
    it { is_expected.not_to be_valid }
  end

  # < 3 chars
  describe FactoryGirl.build(:artist_name, :name => 'a') do
    it { is_expected.not_to be_valid }
  end

  # < 3 chars
  describe FactoryGirl.build(:artist_name, :name => 'ab') do
    it { is_expected.not_to be_valid }
  end

  # > 64 chars
  describe FactoryGirl.build(:artist_name, :name => '12345678901234567890123456789012345678901234567890123456789012345') do
    it { is_expected.not_to be_valid }
  end

  # associated to artist
  describe FactoryGirl.build(:artist_name) do
      it { expect(subject.artist).not_to be_nil }
  end
end
