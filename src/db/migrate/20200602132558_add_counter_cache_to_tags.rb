class AddCounterCacheToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :functions_tags_count, :bigint, index: true
  end
end
