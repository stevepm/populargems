class ConvertFromMarkdown
  def initialize
    # renderer = HTMLwithPygments
    renderer = Redcarpet::Render::HTML.new(filter_html: true, prettify: true, no_styles: true, filter_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, disable_indented_code_blocks: true)
  end

  def render(input)
    @markdown.render(input)
  end

end

# class HTMLwithPygments < Redcarpet::Render::HTML
#   def block_code(code, language)
#     Pygments.highlight(code, lexer: language)
#   end
# end