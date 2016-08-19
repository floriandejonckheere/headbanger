require 'rails_helper'

describe User do
  describe FactoryGirl.build(:user) do
    it { is_expected.to be_valid }
  end

  describe FactoryGirl.build(:user, :email => nil) do
    it { is_expected.not_to be_valid }
  end

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :admin? }

  describe FactoryGirl.build(:user, :admin => true) do
    it { expect(subject.admin?).to be true }
  end
end
