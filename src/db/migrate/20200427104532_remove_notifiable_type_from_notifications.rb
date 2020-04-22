class RemoveNotifiableTypeFromNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications do |t|
      t.remove :notifiable_type
      t.remove :action
      t.string :type
    end
  end
end
