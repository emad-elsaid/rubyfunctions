class CreateFunctions < ActiveRecord::Migration[6.0]
  def change
    create_table :functions do |t|
      t.string :name, null: false
      t.text :usage, null: false
      t.text :code, null: false

      t.timestamps
    end
  end
end
