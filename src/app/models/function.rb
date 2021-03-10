class Function < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }, format: { with: /\A[0-9a-z_]+[?!]?\z/i }
  validates :tags, length: { minimum: 0, maximum: 3, message: :maximum_tags_exceeded }
  validates :usage, presence: true
  validates :code, presence: true, code: true
  validates :user, presence: true

  belongs_to :user, counter_cache: true

  before_validation :assign_function_name

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :saves, dependent: :destroy

  has_many :functions_tags, dependent: :destroy
  has_many :tags, through: :functions_tags

  def tags_list
    tags.map(&:name).join(', ')
  end

  def tags_list=(new_value)
    tag_names = new_value.split(',').reject(&:blank?)
    self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip&.downcase) }
  end

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
