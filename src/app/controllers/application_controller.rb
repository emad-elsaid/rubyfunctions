class ApplicationController < ActionController::Base
  include PermissionsConcern

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end
end
