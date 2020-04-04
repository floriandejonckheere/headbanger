# frozen_string_literal: true

module QueueableController
  extend ActiveSupport::Concern

  included do
    def queue
      current_user.queued_items << resource

      redirect_to request.env["HTTP_REFERER"]
    end

    def unqueue
      current_user.queued_items.delete resource

      redirect_to request.env["HTTP_REFERER"]
    end

    private

    def resource
      @resource ||= controller_name.classify.constantize.find params[:id]
    end
  end
end
