# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    result = Schema.execute params[:query],
                            variables: ensure_hash(params[:variables]),
                            context: graphql_context(:user),
                            operation_name: params[:operationName]

    render json: result unless performed?
  rescue StandardError => e
    logger.error(e)
    logger.error e.backtrace.join("\n")
    Raven.capture_exception(e)

    raise e unless Rails.env.development?

    render json: { errors: [Errors::InternalServerError.new(e).to_h], data: {} }, status: :internal_server_error
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
