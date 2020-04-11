class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :likeable }

  belongs_to :likeable, polymorphic: true, counter_cache: true
  belongs_to :user, counter_cache: true
end
