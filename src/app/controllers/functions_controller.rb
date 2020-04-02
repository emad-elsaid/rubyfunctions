class FunctionsController < ApplicationController
  before_action :set_user
  before_action :set_function, only: %i[show edit update destroy]
  before_action :check_permission, only: %i[show edit update destroy]

  LIMIT = 30

  def index
    @function = @user.functions.new
    check_permission

    offset = params.fetch(:offset, 0).to_i
    @functions = @user.functions.limit(LIMIT).offset(offset).order(created_at: :desc).all
    @next = offset + LIMIT if @functions.count == LIMIT
  end

  def show
    @comment = Comment.new(function: @function, user: current_user)
  end

  # GET /functions/new
  def new
    @function = @user.functions.new
    check_permission
  end

  def edit; end

  def create
    @function = @user.functions.new(function_params)
    check_permission

    if @function.save
      redirect_to [@user, @function], notice: 'Function was successfully created.'
    else
      render :new
    end
  end

  def update
    if @function.update(function_params)
      redirect_to [@user, @function], notice: 'Function was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @function.destroy
    redirect_to user_functions_url(@user), notice: 'Function was successfully deleted.'
  end

  private

  def set_user
    @user = User.from_param(params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_function
    @function = @user.functions.from_param(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end

  # Only allow a trusted parameter "white list" through.
  def function_params
    params.require(:function).permit(:name, :usage, :code)
  end

  def check_permission
    raise Unauthorized unless can?(current_user, @function, action_name.to_sym)
  end
end
