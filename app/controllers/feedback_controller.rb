# frozen_string_literal: true

class FeedbackController < ApplicationController
  before_action :authenticate_user!

  layout 'session'

  def new
    render 'app/feedback'
  end

  def create
    @feedback = Feedback.new feedback_params
    @feedback.request = request
    if @feedback.deliver
      flash[:notice] = 'Thank you for taking a moment to provide feedback!'
    else
      flash[:error] = 'Unable to send message'
    end

    redirect_to root_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:category, :description)
  end
end
