class UpdateCacheCounters < ActiveRecord::Migration[6.0]
  def up
    User.pluck(:id).each { |id| User.reset_counters(id, :comments, :functions, :likes, :saves) }
    Function.pluck(:id).each { |id| Function.reset_counters(id, :comments, :likes, :saves) }
  end
end
