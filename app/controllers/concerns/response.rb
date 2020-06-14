module Response

  def success_response(response, status = :ok)
    render json: response.as_json, status: status
  end

  def error_message_response(message, status = :bad_request)
    response = { message: message }
    render json: response.as_json, status: status
  end

  def error_redirection_response(message, status = :internal_server_error)
    Rails.application.config.logger.error "#{message}" if Rails.env.production?
    redirect_to :controller => 'error', :action => 'index'
  end

  def not_found_redirection(message)
    Rails.application.config.logger.error "#{message}" if Rails.env.production?
    redirect_to :controller => 'notfound', :action => 'index'
  end

  def redirect(url)
    redirect_to url
  end

end
