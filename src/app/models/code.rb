class Code
  attr_reader :code

  def initialize(code)
    @code = code.to_s
    @valid = true
    parse_code
  end

  def valid?
    @valid
  end

  def functions
    return [] unless @valid

    @functions ||= extract_functions(@ast)
  end

  private

  def parse_code
    @ast = RubyVM::AbstractSyntaxTree.parse(@code)
  rescue SyntaxError
    @valid = false
  end

  def extract_functions(ast)
    return [] unless ast.is_a?(RubyVM::AbstractSyntaxTree::Node)

    children = ast.children
    return [children.first.to_s] if ast.type == :DEFN

    children.sum do |child|
      extract_functions(child)
    end
  end
end
