class Tag < ApplicationRecord
  validates :name, uniqueness: true,
                   presence: true,
                   length: { minimum: 3, maximum: 20 },
                   format: { with: /\A[a-z0-9\-]+\z/i }

  has_many :functions_tags, dependent: :destroy
  has_many :functions, through: :functions_tags

  def to_param
    name
  end

  def self.from_param(name)
    find_by(name: name)
  end
end
