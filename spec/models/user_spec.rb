# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string           default(""), not null
#  encrypted_password   :string           default(""), not null
#  sign_in_count        :integer          default(0), not null
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string
#  last_sign_in_ip      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  name                 :string
#  authentication_token :string
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  () UNIQUE
#

require 'rails_helper'

describe User do
  it { puts 'email'; is_expected.to respond_to :email }
  it { puts 'name'; is_expected.to respond_to :name }
  it { puts 'admin'; is_expected.to respond_to :is_admin? }
end
