module Notification
  class Notification < ApplicationRecord
    belongs_to :recipient, class_name: 'User', inverse_of: :notifications
    belongs_to :actor, class_name: 'User'

    scope :unread, -> { where(read_at: nil) }
  end
end
