class AddNotifiableTypeToNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications do |t|
      t.string :notifiable_type
    end
  end
end
