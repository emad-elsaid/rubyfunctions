class Function < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }, format: { with: /\A[0-9a-z_]+[\?!]?\z/i }
  validates :usage, presence: true
  validates :code, presence: true, code: true
  validates :user, presence: true

  belongs_to :user, counter_cache: true

  before_validation :assign_function_name

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :saves, dependent: :destroy

  def to_param
    name
  end

  def self.from_param(param)
    find_by(name: param)
  end

  private

  def assign_function_name
    first_function = Code.new(code).functions.first
    self.name = first_function if first_function
  end
end
