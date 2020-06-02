class FollowershipsController < ApplicationController
  layout 'users'

  before_action :set_user
  before_action :set_followership, only: %i[destroy]
  before_action :check_permission, only: %i[destroy]

  LIMIT = 30

  def index
    offset = params.fetch(:offset, 0).to_i
    @users = scope.limit(LIMIT).offset(offset).order(created_at: :desc).all
    @next = offset + LIMIT if @users.size == LIMIT
  end

  def create
    @followership = current_user.following_followerships.new(followee: @user)
    check_permission

    if @followership.save
      redirect_back fallback_location: [@user, :functions]
    else
      redirect_back fallback_location: [@user, :functions], alert: @followership.errors.full_messages
    end
  end

  def destroy
    @followership.destroy
    redirect_back fallback_location: [@user, :functions]
  end

  private

  def scope
    case params[:relationship]
    when 'followees'
      @user.followees
    when 'followers'
      @user.followers
    else
      raise(ActiveRecord::RecordNotFound)
    end
  end

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_followership
    @followership = current_user.following_followerships.find_by!(followee: @user)
  end

  def check_permission
    raise UnauthorizedException unless can?(@followership, action_name.to_sym)
  end
end
