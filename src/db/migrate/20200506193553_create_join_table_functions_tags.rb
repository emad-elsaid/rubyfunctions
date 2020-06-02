class CreateJoinTableFunctionsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :functions_tags do |t|
      t.belongs_to :function
      t.belongs_to :tag
      t.index %i[function_id tag_id], unique: true

      t.timestamps
    end
  end
end
