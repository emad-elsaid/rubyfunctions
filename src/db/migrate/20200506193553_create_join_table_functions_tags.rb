class CreateJoinTableFunctionsTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :functions, :tags do |t|
      t.index %i[function_id tag_id]
    end
  end
end
