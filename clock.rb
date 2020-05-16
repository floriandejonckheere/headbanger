# frozen_string_literal: true

require "clockwork"
require "active_support/time"

module Clockwork
  handler { |j| j.constantize.new.perform_later }
end
