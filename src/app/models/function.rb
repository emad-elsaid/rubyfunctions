class Function < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :usage, presence: true
  validates :code, presence: true

  def to_param
    name
  end

  def self.from_param(param)
    find_by(name: param)
  end
end
