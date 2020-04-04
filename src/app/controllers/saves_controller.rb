class SavesController < ApplicationController
  before_action :set_user, only: %i[index create destroy]
  before_action :set_function, only: %i[create destroy]
  before_action :set_save, only: :destroy

  LIMIT = 30

  def index
    offset = params.fetch(:offset, 0).to_i
    @saves = @user.saves.includes(:function).limit(LIMIT).offset(offset).order(created_at: :desc).all
    @next = offset + LIMIT if @saves.count == LIMIT
  end

  def create
    @save = current_user.saves.new(function: @function)
    raise UnauthorizedException unless can?(@save, action_name.to_sym)

    @save.save
    redirect_back fallback_location: [@user, @function]
  end

  def destroy
    @save.destroy
    raise UnauthorizedException unless can?(@save, action_name.to_sym)

    redirect_back fallback_location: [@user, @function]
  end

  private

  def set_function
    @function = @user.functions.from_param(params[:function_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  def set_save
    @save = current_user.saves.find_by(function: @function) || raise(ActiveRecord::RecordNotFound)
  end
end
