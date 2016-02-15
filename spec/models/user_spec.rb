require 'rails_helper'

describe User do
  it { puts 'email'; is_expected.to respond_to :email }
  it { puts 'name'; is_expected.to respond_to :name }
  it { puts 'admin'; is_expected.to respond_to :is_admin? }
end
