module NotificationsHelper
  def notification_liked_url(notification)
    function = notification.notifiable
    user_function_url(id: function, user_id: function.user)
  end

  def unread_notifications(user)
    user.notifications.unread.count
  end

  def unread?(notification)
    notification.read_at.nil?
  end
end
