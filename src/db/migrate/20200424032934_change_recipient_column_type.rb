class ChangeRecipientColumnType < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :notifications, :users, column: :recipient_id
    add_foreign_key :notifications, :users, column: :actor_id
  end
end
