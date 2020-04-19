class ApplicationController < ActionController::Base
  include SentryConcern if Rails.env.production?
  include PermissionsConcern

  rescue_from UnauthorizedException, with: :unauthorized

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  private

  def unauthorized
    redirect_to root_path, alert: 'You do not have enough permissions to perform this action'
  end
end
