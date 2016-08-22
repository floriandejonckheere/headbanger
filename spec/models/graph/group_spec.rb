require 'rails_helper'

describe Graph::Group do
  before :each  do
    Graph::Group.delete_all
  end

  it { is_expected.to respond_to :year_formed }
  it { is_expected.to respond_to :names }
  it { is_expected.to respond_to :country }
  it { is_expected.to respond_to :artists }
  it { is_expected.to respond_to :lyrical_themes }
  it { is_expected.to respond_to :releases }
  it { is_expected.to respond_to :description }
end

describe FactoryGirl.build(:group) do
  it { is_expected.to be_valid }
  it { expect(subject.names.any?).to be false }
  it { expect(subject.artists.any?).to be false }
  it { expect(subject.lyrical_themes.any?).to be false }
  it { expect(subject.releases.any?).to be false }
end

describe FactoryGirl.build(:group_active) do
  it { expect(subject.is_active?).to be true }
end

describe FactoryGirl.build(:group_split_up) do
  it { expect(subject.is_split_up?).to be true }
end

describe FactoryGirl.build(:group_on_hold) do
  it { expect(subject.is_on_hold?).to be true }
end

describe FactoryGirl.build(:group_changed_name) do
  it { expect(subject.is_changed_name?).to be true }
end

describe FactoryGirl.build(:group_disputed) do
  it { expect(subject.is_disputed?).to be true }
end

describe FactoryGirl.build(:group_unknown) do
  it { expect(subject.is_unknown?).to be true }
end
