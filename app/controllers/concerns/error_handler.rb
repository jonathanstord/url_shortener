module ErrorHandler
  include Response
  def self.included(clazz)
    clazz.class_eval do
      rescue_from StandardError, with: :unknown_failure
      rescue_from ActiveModel::StrictValidationFailed, with: :validation_failure
      rescue_from ActiveRecord::RecordInvalid, with: :validation_failure
      rescue_from ArgumentError, with: :validation_failure
      rescue_from ActionController::ParameterMissing, with: :validation_failure
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
    end
  end

  private

  def validation_failure(err)
    error_message_response(err.message, :bad_request)
  end

  def not_found(_err)
    not_found_redirection(_err.message)
  end

  def unknown_failure(err)
    error_redirection_response(err.message, :internal_server_error)
  end

end
