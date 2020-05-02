class NotificationsController < ApplicationController
  include NotificationsHelper

  LIMIT = 10

  before_action :check_permission

  def index
    offset = params.fetch(:offset, 0).to_i
    @state = params[:state]
    @notifications = get_notifications(@state).limit(LIMIT).offset(offset).order(created_at: :desc)
    @next = offset + LIMIT if @notifications.size == LIMIT
  end

  def show
    @notification = current_user.notifications.find(params[:id]) || raise(ActiveRecord::RecordNotFound)
    @notification.update!(read_at: DateTime.now) unless @notification.read_at
    redirect_to @notification
  end

  private

  def check_permission
    raise UnauthorizedException if current_user.nil?
  end

  def get_notifications(state)
    notifications = current_user.notifications
    case state
    when 'unread'
      notifications.unread
    when 'read'
      notifications.read
    else
      notifications
    end
  end
end
