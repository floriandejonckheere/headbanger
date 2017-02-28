require 'rails_helper'

describe User do
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :display_name }

  it 'is valid with attributes' do
    user = build :user
    expect(user).to be_valid
  end

  it 'is invalid without email' do
    user = build :user, :email => nil
    expect(user).not_to be_valid
  end

  it 'has a fallback display name' do
    user = build :user
    expect(user.display_name).to equal(user.name)

    user = build :user, :name => nil
    expect(user.display_name).to equal(user.email)
  end
end
