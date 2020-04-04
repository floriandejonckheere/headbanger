# frozen_string_literal: true

module RateableController
  extend ActiveSupport::Concern

  included do
    def rate
      current_user.rated << resource

      redirect_to :back
    end

    def unrate
      current_user.rated.delete resource

      redirect_to :back
    end

    private

    def resource
      @resource ||= controller_name.classify.constantize.find params[:id]
    end

    def back_url
      if params[:redirect]
        @url = params[:redirect]
      else
        @url = request.env["HTTP_REFERER"]
        @url ||= url_for controller: "app", action: "home"
      end
    end
  end
end
