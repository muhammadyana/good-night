module ApiHelper
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
    rescue_from ActionController::RoutingError,      with: :render_not_found
    rescue_from AbstractController::ActionNotFound,  with: :render_not_found
    rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
  end

  def default_status
    {
      ok: 'Success',
      success: 'Success',
      created: 'Resource created',
      accepted: 'Resource accepted',
      not_acceptable: 'Not Acceptable',
      not_found: 'Resource not found',
      bad_request: 'Bad request',
      unauthorized: 'Unauthorized access',
      unprocessable_entity: 'Unprocessable Entity',
      resource_conflict: 'Resource already existed',
      record_invalid: 'Record invalid',
      forbidden: 'Forbidden',
      internal_server_error: 'internal server error'
    }
  end

  def default_code
    {
      ok: 200,
      success: 200,
      created: 201,
      accepted: 202,
      not_acceptable: 406,
      bad_request: 400,
      unauthorized: 401,
      not_found: 404,
      unprocessable_entity: 422,
      resource_conflict: 409,
      forbidden: 403,
      internal_server_error: 500
    }
  end

  # Shorthand method for returning json responses.
  #
  # @param code (symbol) - Rails status code symbols.
  # @param message (string) - Custom message.
  # @param args (Hash) - Additional parameters to be attached in the body.
  def responder(status, message = nil, args = {})
    logger.info("===== status is #{status}")
    status ||= default_status[status]
    code = default_code[status]
    args ||= {}

    response_data = {
      success: success_responses.include?(status),
      code: code,
      status: default_status[status],
      message: message
    }.merge(args)

    render json: response_data
  end

  def success_responses
    %i[ok success accepted created]
  end

  private

  def render_not_found(exception)
    logger.info("==== Error Log #{exception}") # for logging
    # render json: { message: I18n.t('api.errors.not_found'), success: false, status: :not_found }, status: :not_found
    responder(:not_found, "Record or object not found")
  end

  def render_record_invalid(exception)
    logger.info(exception) # for logging
    render json: { messages: exception.record.errors.as_json, success: false, status: :bad_request }, status: :bad_request
  end

  def render_parameter_missing(exception)
    logger.info(exception) # for logging
    render json: { message: I18n.t('api.errors.missing_param'), success: false, status: :unprocessable_entity }, status: :unprocessable_entity
  end
end
