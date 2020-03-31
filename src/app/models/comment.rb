class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :function

  default_scope { order(:created_at) }
end
