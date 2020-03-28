class SessionsController < ApplicationController
  def destroy
    reset_session
    redirect_to root_path, notice: 'Goodbye and see you later...'
  end
end
