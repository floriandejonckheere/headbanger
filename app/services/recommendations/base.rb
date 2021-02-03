# frozen_string_literal: true

module Recommendations
  class Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call(_number)
      raise NotImplementedError, "Implement this method in your subclass"
    end
  end
end
