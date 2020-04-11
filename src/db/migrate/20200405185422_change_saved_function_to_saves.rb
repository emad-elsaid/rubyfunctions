class ChangeSavedFunctionToSaves < ActiveRecord::Migration[6.0]
  def change
    rename_table 'saved_functions', 'saves'
  end
end
