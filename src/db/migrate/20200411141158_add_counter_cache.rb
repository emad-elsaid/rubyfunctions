class AddCounterCache < ActiveRecord::Migration[6.0]
  def change
    change_users
    change_functions
  end

  def change_users
    change_table :users, bulk: true do |t|
      t.column :comments_count, :integer
      t.column :functions_count, :integer
      t.column :likes_count, :integer
      t.column :saves_count, :integer
    end
  end

  def change_functions
    change_table :functions, bulk: true do |t|
      t.column :comments_count, :integer
      t.column :likes_count, :integer
      t.column :saves_count, :integer
    end
  end
end
