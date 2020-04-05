class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.index %i[user_id likeable_id likeable_type], unique: true

      t.timestamps
    end
  end
end
