require 'rails_helper'

RSpec.describe FunctionsHelper do
  describe '#render_markdown' do
    context 'normal text' do
      it { expect(helper.render_markdown('text')).to match('<p>text</p>') }
    end

    context 'bold text' do
      it { expect(helper.render_markdown('**bold**')).to match('<p><strong>bold</strong></p>') }
    end

    context 'italic text' do
      it { expect(helper.render_markdown('*italic*')).to match('<p><em>italic</em></p>') }
    end

    context 'ordered list' do
      it do
        markdown_list = <<~ACTUAL
          1. First
          2. Second
        ACTUAL

        html_list = <<~EXPECTED
          <ol>
            <li>First</li>
            <li>Second</li>
          </ol>
        EXPECTED

        expect(helper.render_markdown(markdown_list)).to match(html_list)
      end
    end

    context 'unordered list' do
      it do
        markdown_list = <<~ACTUAL
          * First
          * Second
        ACTUAL

        html_list = <<~EXPECTED
          <ul>
            <li>First</li>
            <li>Second</li>
          </ul>
        EXPECTED

        expect(helper.render_markdown(markdown_list)).to match(html_list)
      end
    end

    context 'links' do
      it do
        markdown_link = '[RubyFunctions](https://runyfunctions.com)'
        html_link = '<p><a href="https://runyfunctions.com" rel="noopener">RubyFunctions</a></p>'

        expect(helper.render_markdown(markdown_link)).to match(html_link)
      end
    end

    context 'qoutes' do
      it do
        markdown_quote = '> quote'

        html_quote = <<~QUOTE
          <blockquote>
            <p>quote</p>
          </blockquote>
        QUOTE

        expect(helper.render_markdown(markdown_quote)).to match(html_quote)
      end
    end

    context 'code' do
      it 'inline code' do
        markdown = 'Inline `code` has `back-ticks around` it.'
        html = '<p>Inline <code>code</code> has <code>back-ticks around</code> it.</p>'
        expect(helper.render_markdown(markdown)).to match(html)
      end

      it 'code block' do
        markdown = <<~ACTUAL
          ```ruby
          def foo
            p "bar"
          end
          ```
        ACTUAL

        html = <<~EXPECTED
            <pre><code>def foo
            p "bar"
          end
          </code></pre>
        EXPECTED

        expect(helper.render_markdown(markdown).squish).to match(html.squish)
      end
    end

    context 'output does not contain headers' do
      it { expect(helper.render_markdown('# Header')).to_not include('<h1>') }
      it { expect(helper.render_markdown('## Header')).to_not include('<h2>') }
      it { expect(helper.render_markdown('### Header')).to_not include('<h3>') }
    end

    context 'output does not contain images' do
      it { expect(helper.render_markdown('<img src=\'https://example.com\' title=\'title\'/>')).to_not include('<img') }
    end

    context 'output does not contain any unescaped html tags' do
      it { expect(helper.render_markdown('<p>text</p>')).to_not include('<p>') }
      it { expect(helper.render_markdown('<abbr> Click Me </abbr>')).to_not include('<abbr>') }
    end
  end
end
