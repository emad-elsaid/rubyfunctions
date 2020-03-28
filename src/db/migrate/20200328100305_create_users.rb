class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :github_id

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :github_id, unique: true
  end
end
