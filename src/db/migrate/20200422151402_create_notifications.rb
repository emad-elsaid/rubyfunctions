class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :type
      t.integer :recipient_id, index: true
      t.integer :actor_id
      t.datetime :read_at
      t.references :notifiable, polymorphic: true

      t.foreign_key :users, column: :recipient_id
      t.foreign_key :users, column: :actor_id

      t.timestamps
    end
  end
end
