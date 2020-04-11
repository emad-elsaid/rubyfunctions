class RelationshipsController < ApplicationController
  before_action :set_user

  def index
  end

  def create
    relationship = current_user.active_relationships.new(followee: @user)
    render json: { data: params, user: @user, relationship: relationship }
  end

  def destroy
  end

  def set_user
    @user = User.find(params[:relationship][:followee_id]) || raise(ActiveRecord::RecordNotFound)
  end
end
