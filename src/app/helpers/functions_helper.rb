module FunctionsHelper
  def render_code(ruby)
    formatter = Rouge::Formatters::HTMLInline.new('github')
    formatter = Rouge::Formatters::HTMLLinewise.new(formatter)

    lexer = Rouge::Lexers::Ruby.new
    sanitized = sanitize(formatter.format(lexer.lex(ruby)), tags: %w[div span], attributes: %w[style])
    tag.pre sanitized
  end
end
