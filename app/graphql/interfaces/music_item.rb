# frozen_string_literal: true

module Interfaces
  module MusicItem
    include BaseInterface
    description "A music entity"

    field :rating,
          Types::RatingEnum,
          null: true

    def rating
      # FIXME: fetch user from session
      User
        .first
        .ratings
        .find_by(rateable: object)
        &.rating
    end
  end
end
