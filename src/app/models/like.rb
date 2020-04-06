class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :likeable }

  belongs_to :likeable, polymorphic: true
  belongs_to :user
end
