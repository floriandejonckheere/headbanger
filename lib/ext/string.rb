# frozen_string_literal: true

module Ext
  module String
    def sanitize
      ActionView::Base.full_sanitizer.sanitize self
    end
  end
end

String.include Ext::String
