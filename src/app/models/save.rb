class Save < ApplicationRecord
  validates :function, uniqueness: { scope: :user }

  belongs_to :user
  belongs_to :function
end
