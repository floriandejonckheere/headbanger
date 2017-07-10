# frozen_string_literal: true

module RateableController
  extend ActiveSupport::Concern

  included do
    def rate
      current_user.rated << resource

      redirect :back
    end

    def unrate
      current_user.rated.delete resource

      redirect :back
    end

    private

    def resource
      @resource ||= controller_name.classify.constantize.find params[:id]
    end
  end
end
