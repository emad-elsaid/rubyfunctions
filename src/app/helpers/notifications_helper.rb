module NotificationsHelper
  def notification_liked_url(notification)
    function = Function.find_by(user_id: notification.recipient, id: notification.notifiable_id)
    user_function_url(id: function, user_id: function.user)
  end
end
