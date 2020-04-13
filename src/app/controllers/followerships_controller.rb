class FollowershipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_back fallback_location: [@user, :functions]
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back fallback_location: [@user, :functions]
  end

  private

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end
end
