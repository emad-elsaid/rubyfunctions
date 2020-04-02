class Function < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :usage, presence: true
  validates :code, presence: true
  validates :user, presence: true

  belongs_to :user

  before_validation :function_name

  def to_param
    name
  end

  def self.from_param(param)
    find_by(name: param)
  end

  private

  def find_first_function(ast)
    return ast.children.first.to_s if ast.respond_to?('type') && ast.type == :DEFN

    return unless ast.respond_to?('children')

    ast.children.each do |child|
      func_name = find_first_function(child)
      return func_name if func_name
    end
  end

  def function_name
    self.name = find_first_function(RubyVM::AbstractSyntaxTree.parse(code))
  rescue SyntaxError
    errors.add(:has_syntax_error, 'code has syntax error')
    throw(:abort)
  end
end
