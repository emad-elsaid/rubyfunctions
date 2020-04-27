class AddNotifiableIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :notifiable_id, :integer
  end
end
