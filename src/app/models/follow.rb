class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User', inverse_of: :follower_relationships
  belongs_to :following, foreign_key: :following_id, class_name: 'User', inverse_of: :following_relationships
end
