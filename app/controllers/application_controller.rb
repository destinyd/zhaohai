class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :log_user_agent

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def log_user_agent
    logger.info "HTTP_USER_AGENT #{request.env["HTTP_USER_AGENT"]}" if ENV['RAILS_ENV'] == 'production'
  end
end
