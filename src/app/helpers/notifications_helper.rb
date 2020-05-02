module NotificationsHelper
  def redirect_to_function(function)
    user_function_url(id: function, user_id: function.user)
  end

  def notification_commented_url(notification)
    redirect_to_function notification.notifiable
  end

  def notification_liked_url(notification)
    redirect_to_function notification.notifiable
  end

  def unread_notifications(user)
    user.notifications.unread.count
  end
end
