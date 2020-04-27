module Notification
  class Commented < Notification
    has_many :functions, as: :notifiable, dependent: :destroy
  end
end
