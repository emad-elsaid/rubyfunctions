class Save < ApplicationRecord
  validates :function, uniqueness: { scope: :user }

  belongs_to :user, counter_cache: true
  belongs_to :function, counter_cache: true
end
