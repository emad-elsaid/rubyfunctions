class NotificationsController < ApplicationController
  LIMIT = 30

  def index
    offset = params.fetch(:offset, 0).to_i
    @notifications = current_user.notifications.limit(LIMIT).offset(offset).order(created_at: :desc)
    @next = offset + LIMIT if @notifications.size == LIMIT
  end

  def show
    @notification = current_user.notifications.find(params[:id]) || raise(ActiveRecord::RecordNotFound)
    @notification.update!(read_at: DateTime.now) unless @notification.read_at
    redirect_to @notification
  end
end
