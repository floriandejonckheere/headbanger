# frozen_string_literal: true

class GroupRelease < ApplicationRecord
  belongs_to :group
  belongs_to :release
end
