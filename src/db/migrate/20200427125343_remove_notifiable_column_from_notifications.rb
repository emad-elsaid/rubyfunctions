class RemoveNotifiableColumnFromNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications do |t|
      t.remove :notifiable_id
    end
  end
end
