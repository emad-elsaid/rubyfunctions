class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_function
  before_action :set_comment, only: %i[destroy]
  before_action :check_permission, only: %i[destroy]

  def create
    @comment = @function.comments.create_with(user: current_user).new(comment_params)
    check_permission

    if @comment.save
      redirect_to [@user, @function], notice: 'Your comment was successfully created.'
    else
      redirect_to [@user, @function], alert: @comment.errors.full_messages
    end
  end

  def destroy
    @comment.destroy
    redirect_to [@user, @function], notice: 'Comment was successfully deleted.'
  end

  private

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_function
    @function = @user.functions.from_param(params[:function_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_comment
    @comment = @function.comments.find(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def check_permission
    raise Unauthorized unless can?(current_user, @comment, action_name.to_sym)
  end
end
