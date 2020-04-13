class Followership < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followee, class_name: :User

  validates :followee, uniqueness: { scope: :follower }
  validate :follower_and_followee

  private

  def follower_and_followee
    errors.add(:follower, :cant_follow_self) if follower == followee
  end
end
