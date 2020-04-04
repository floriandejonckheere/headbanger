# frozen_string_literal: true

module Authentication
  class TermsController < ApplicationController
    layout "session"

    ##
    # Terms of Service
    #
    def terms_of_service; end

    ##
    # Privacy policy
    #
    def privacy_policy; end
  end
end
