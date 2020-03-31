class ApplicationController < ActionController::Base
  include PermissionsConcern

  before_action :set_raven_context if Rails.env.production?

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  private

  def set_raven_context
    return unless current_user

    Raven.user_context(user: current_user.username)
  end
end
