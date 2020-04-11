class AddUniqueCompoundIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :saves, %i[user_id function_id], unique: true
  end
end
