require 'rails_helper'

describe Graph::Artist do
  it { is_expected.to respond_to :gid }
  it { is_expected.to respond_to :date_of_birth }
  it { is_expected.to respond_to :artist_names }
  it { is_expected.to respond_to :groups }
end
