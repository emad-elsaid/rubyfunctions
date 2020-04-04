class Function < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }, format: { with: /\A[0-9a-z_]+[\?!]?\z/i }
  validates :usage, presence: true
  validates :code, presence: true
  validates :user, presence: true

  belongs_to :user

  has_many :comments, dependent: :destroy

  def to_param
    name
  end

  def self.from_param(param)
    find_by(name: param)
  end
end
