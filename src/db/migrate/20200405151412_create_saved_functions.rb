class CreateSavedFunctions < ActiveRecord::Migration[6.0]
  def change
    create_table :saved_functions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :function, null: false, foreign_key: true

      t.timestamps
    end
  end
end
