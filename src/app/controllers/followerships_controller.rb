class FollowershipsController < ApplicationController
  before_action :set_user
  before_action :set_followership, only: %(destroy)
  def create
    @followership = current_user.followings.create(followee: @user)
    redirect_back fallback_location: [@user, :functions]
  end

  def destroy
    @followership.destroy
    redirect_back fallback_location: [@user, :functions]
  end

  private

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_followership
    @followership = current_user.followings.find_by!(followee: @user)
  end
end
