class RemoveNotifiableTypeFromNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications, bulk: true do |t|
      t.string :type
      remove_column :notifications, :notifiable_type, :string
      remove_column :notifications, :action, :string
    end
  end
end
