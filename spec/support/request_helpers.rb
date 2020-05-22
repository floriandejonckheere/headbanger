# frozen_string_literal: true

module RequestHelpers
  def response_body
    JSON.parse(response.body)
  end
end
