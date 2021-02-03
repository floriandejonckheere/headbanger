# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    return false unless user && record

    user.admin? || user == record
  end

  def delete?
    return false unless user && record

    user.admin? || user == record
  end
end
