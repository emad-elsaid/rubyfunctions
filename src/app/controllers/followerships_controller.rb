class FollowershipsController < ApplicationController
  before_action :set_user
  before_action :set_followership, only: %(destroy)

  LIMIT = 30

  def index
    offset = params.fetch(:offset, 0).to_i
    @followers = @user.followers.includes(:follower).limit(LIMIT).offset(offset).order(created_at: :desc).all
    @next = offset + LIMIT if @followers.size == LIMIT
  end

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
