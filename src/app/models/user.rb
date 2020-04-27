class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-z_\-]+\z/i }
  validates :github_id, presence: true, uniqueness: true

  has_many :functions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :saves, dependent: :destroy

  has_many :notifications, foreign_key: :recipient_id, inverse_of: :recipient,
                           class_name: 'Notification::Notification', dependent: :destroy

  has_many :followings, class_name: :Followership, foreign_key: :follower_id,
                        inverse_of: :follower, dependent: :destroy

  has_many :followers, class_name: :Followership, foreign_key: :followee_id,
                       inverse_of: :followee, dependent: :destroy

  def to_param
    username
  end

  def self.from_param(username)
    find_by(username: username)
  end

  def self.find_or_create_from_github_user(github_user)
    find_or_create_by!(github_id: github_user['id']) do |new_user|
      username = github_user['login']
      new_user.username = exists?(github_id: username) ? SecureRandom.uuid : username
      new_user.name = github_user['name'] || username
    end
  end
end
