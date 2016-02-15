require 'rails_helper'

describe User do
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :is_admin? }

  describe Fabricate(:user, :admin => true) do
    it { expect(subject.is_admin?).to be true }
  end

end
