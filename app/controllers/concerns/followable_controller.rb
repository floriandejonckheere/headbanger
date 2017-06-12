# frozen_string_literal: true

module FollowableController
  extend ActiveSupport::Concern

  included do
    def follow
      current_user.following << resource

      redirect_to resource
    end

    def unfollow
      current_user.following.delete resource

      redirect_to resource
    end

    private

    def resource
      @resource ||= controller_name.classify.constantize.find params[:id]
    end
  end
end
