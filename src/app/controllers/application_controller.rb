class ApplicationController < ActionController::Base
  include SentryConcern if Rails.application.config_for(:rescue)[:report_to_sentry]
  include PermissionsConcern

  rescue_from UnauthorizedException, with: :unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found if Rails.application.config_for(:rescue)[:record_not_found]

  helper_method :current_user

  def current_user
    return unless session.key? :user

    @current_user ||= User.find_by(id: session[:user])
  end

  private

  def unauthorized
    redirect_to root_path, alert: 'You do not have enough permissions to perform this action'
  end

  def not_found
    redirect_to '/404.html'
  end
end
