# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :authenticate_user!

  # GET /lists
  def index
    @lists = current_user.lists
  end

  # POST /lists
  def create
    @list = List.new list_params.merge :owner => current_user

    if @list.save
      redirect_to lists_path
    else
      render 'new'
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/:id/edit
  def edit
    @list = List.find params[:id]
  end

  # GET /lists/:id
  def show
    @list = List.find params[:id]
  end

  # PATCH /lists/:id
  def update
    @list = List.find params[:id]
    if @list.update list_params
      redirect_to list_path @list
    else
      render 'edit'
    end
  end

  # DELETE /lists/:id
  def destroy
    @list = List.find params[:id]
    if @list.destroy
      flash[:info] = "List '#{@list.name}' deleted"
      redirect_to lists_path
    else
      render 'edit'
    end
  end

  private
  def list_params
    params.require(:list).permit :name,
                                 :description
  end
end
