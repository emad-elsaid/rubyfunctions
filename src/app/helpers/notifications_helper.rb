module NotificationsHelper
  def notification_liked_url(notification)
    function = notification.notifiable
    user_function_url(id: function, user_id: function.user)
  end
end
