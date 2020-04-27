module Notification
  class Liked < Notification
    has_many :functions, as: :notifiable, dependent: :destroy
  end
end
