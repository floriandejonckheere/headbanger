require 'rails_helper'



describe Graph::Artist do
  before :each  do
    Graph::Artist.delete_all
  end

  it { is_expected.to respond_to :root_node }
  it { is_expected.to respond_to :date_of_birth }
  it { is_expected.to respond_to :date_of_death }
  it { is_expected.to respond_to :names }
  it { is_expected.to respond_to :groups }
end

describe FactoryGirl.build(:artist) do
  it { is_expected.to be_valid }
end

describe FactoryGirl.build(:artist_alive) do
  it { expect(subject.date_of_birth).not_to be_nil }
end

describe FactoryGirl.build(:artist_dead) do
  it { expect(subject.date_of_birth).not_to be_nil }
  it { expect(subject.date_of_death).not_to be_nil }
end
