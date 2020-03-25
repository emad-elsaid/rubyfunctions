class AddUniquenessToName < ActiveRecord::Migration[6.0]
  def change
    add_index :functions, :name, unique: true
  end
end
