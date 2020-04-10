module FunctionsHelper
  def render_code(ruby)
    formatter = Rouge::Formatters::HTMLInline.new('github')
    formatter = Rouge::Formatters::HTMLLinewise.new(formatter)

    lexer = Rouge::Lexers::Ruby.new
    sanitized = sanitize(formatter.format(lexer.lex(ruby)), tags: %w[div span], attributes: %w[style])
    tag.pre sanitized
  end

  def render_markdown(str)
    options = { input: 'GFM', auto_id_stripping: true, syntax_highlighter: nil }
    allowed_tags = %w[p a ul ol li del strong em blockquote code pre span div]
    allowed_attributes = %w[href rel]

    kramdown_doc = Kramdown::Document.new(str, options)
    sanitize(kramdown_doc.to_html_from_markdown, tags: allowed_tags, attributes: allowed_attributes)
  end
end
