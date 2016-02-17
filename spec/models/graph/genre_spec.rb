require 'rails_helper'

describe Graph::Genre do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :subgenres }

  describe FactoryGirl.build(:genre, :name => nil) do
    it { is_expected.not_to be_valid }
  end
end
