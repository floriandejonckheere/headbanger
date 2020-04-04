# frozen_string_literal: true

if Rails.env.development?
  require "sidekiq/testing"
  Sidekiq::Testing.inline!
end
