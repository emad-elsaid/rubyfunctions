class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :followee, table: :users, index: true
      t.references :follower, table: :users, index: true

      t.timestamps

      t.index %i[followee_id, follower_id], unique: true
    end
  end
end
