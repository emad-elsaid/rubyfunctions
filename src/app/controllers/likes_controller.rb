class LikesController < ApplicationController
  before_action :set_user
  before_action :set_function

  def create
    @like = @function.likes.new(user: current_user)
    raise UnauthorizedException unless can?(@like, action_name.to_sym)

    if @like.save
      notify_user
      redirect_back fallback_location: [@user, @function]
    else
      redirect_back fallback_location: [@user, @function], alert: @like.errors.full_messages
    end
  end

  def destroy
    @like = @function.likes.find_by(user: current_user) || raise(ActiveRecord::RecordNotFound)
    raise UnauthorizedException unless can?(@like, action_name.to_sym)

    @like.destroy
    redirect_back fallback_location: [@user, @function]
  end

  private

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_function
    @function = @user.functions.from_param(params[:function_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def notify_user
    Notification::Liked.create(recipient: @function.user, actor: current_user, notifiable_id: @function.id)
  end
end
