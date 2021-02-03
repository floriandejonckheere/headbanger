# frozen_string_literal: true

RSpec.describe UserPolicy do
  subject(:policy) { described_class.new(user, record) }

  let(:user) { build(:user) }
  let(:record) { build(:user) }

  it { is_expected.to permit_action :show }
  it { is_expected.to forbid_actions :update, :delete }

  context "when the record is the user itself" do
    let(:record) { user }

    it { is_expected.to permit_actions :show, :update, :delete }
  end

  context "when the user is admin" do
    let(:user) { build(:admin) }

    it { is_expected.to permit_actions :show, :update, :delete }

    context "when the record is the user itself" do
      let(:record) { user }

      it { is_expected.to permit_actions :show, :update, :delete }
    end
  end
end
