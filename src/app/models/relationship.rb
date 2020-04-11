class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followee, class_name: :User

  validates :followee, uniqueness: { scope: :follower }
  validate :follower_and_followee

  def follower_and_followee
    errors.add(:follower, "User Can't Follow Himself") if follower_id == followee_id
  end
end
