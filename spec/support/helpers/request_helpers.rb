# frozen_string_literal: true

module RequestHelpers
  def response_body
    JSON
      .parse(response.body)
      .deep_symbolize_keys
  end

  def default_user
    @default_user ||= create(:user)
  end
end
