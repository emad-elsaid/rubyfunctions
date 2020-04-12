class ChangeCounterColumnDefault < ActiveRecord::Migration[6.0]
  def change
    %i[comments_count likes_count saves_count].each do |column|
      change_column_default :functions, column, from: nil, to: 0
    end

    %i[comments_count functions_count likes_count saves_count].each do |column|
      change_column_default :users, column, from: nil, to: 0
    end

    User.pluck(:id).each { |id| User.reset_counters(id, :comments, :functions, :likes, :saves) }
    Function.pluck(:id).each { |id| Function.reset_counters(id, :comments, :likes, :saves) }
  end
end
