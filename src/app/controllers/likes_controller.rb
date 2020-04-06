class LikesController < ApplicationController
  before_action :set_user
  before_action :set_function

  def create
    @like = @function.likes.new(user: current_user)
    raise Unauthorized unless can?(@like, action_name.to_sym)

    @like.save
    redirect_back fallback_location: [@user, @function]
  end

  def destroy
    @like = @function.likes.find_by(user: current_user) || raise(ActiveRecord::RecordNotFound)
    raise Unauthorized unless can?(@like, action_name.to_sym)

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
end
