class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-z_\-\.]+\z/i }
  validates :github_id, presence: true, uniqueness: true
end
