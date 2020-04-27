class RemoveNotifiableColumnFromNotifications < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :notifiable_id, :integer
  end
end
