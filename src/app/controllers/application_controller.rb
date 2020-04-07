class ApplicationController < ActionController::Base
  include PermissionsConcern

  before_action :set_raven_context if Rails.env.production?

  rescue_from UnauthorizedException, with: :unauthorized

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  private

  def set_raven_context
    return unless current_user

    Raven.user_context(user: current_user.username)
  end

  def unauthorized
    redirect_to root_path, alert: 'You do not have enough permissions to perform this action'
  end
end
