class HtmlFromMarkdown < Kramdown::Converter::Html
  alias convert_html_element_parent convert_html_element

  # Strip down all comments, meta data and special tags
  def convert_comment(_elm, _indent)
    ''
  end

  def convert_xml_comment(_elm, _indent)
    ''
  end

  def convert_standalone_image(_elm, _indent)
    ''
  end

  # escape all html tags to be rendered as they are
  # without being fromatted
  def convert_html_element(elm, indent)
    escape_html(convert_html_element_parent(elm, indent))
  end

  # Treat headers as paragraphs <p>
  def convert_header(elm, indent)
    # Strip down the headers from id attribute
    elm.attr.clear

    # Set its type to <p> tag
    elm.type = :p
    convert_p(elm, indent)
  end

  # add 'rel' attribute and set it to 'noopener'
  # https://developers.google.com/web/tools/lighthouse/audits/noopener
  def convert_a(elm, indent)
    elm.attr['rel'] = 'noopener'
    format_as_span_html(elm.type, elm.attr, inner(elm, indent))
  end

  # Treat images as urls
  def convert_img(elm, _indent)
    format_as_span_html(:a, { href: elm.attr['src'] }, elm.attr['title'])
  end
end
