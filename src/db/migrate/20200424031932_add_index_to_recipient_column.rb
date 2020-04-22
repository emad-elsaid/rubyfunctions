class AddIndexToRecipientColumn < ActiveRecord::Migration[6.0]
  def change
    add_index :notifications, :recipient_id
  end
end
