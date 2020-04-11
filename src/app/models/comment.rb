class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :function, counter_cache: true

  default_scope { order(:created_at) }
end
