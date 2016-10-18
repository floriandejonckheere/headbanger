class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.request = request
    if @feedback.deliver
      flash.now[:notice] = 'Thank you for your message'
    else
      flash.now[:error] = 'Unable to send message'
    end
    redirect_back :fallback_location => root_path
  end
end
