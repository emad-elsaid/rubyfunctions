class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user.id)
    redirect_to user_functions_path(@user.username)
  end

  def destroy
    current_user.unfollow(@user.id)
    redirect_to user_functions_path(@user.username)
  end

  def set_user
    @user = User.find(params[:relationship][:followee_id]) || raise(ActiveRecord::RecordNotFound)
  end
end
