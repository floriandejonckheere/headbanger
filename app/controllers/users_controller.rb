# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /lists/:id
  def show
    @user = User.find params[:id]
  end
end
