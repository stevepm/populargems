class ConvertFromMarkdown
  def initialize
    renderer = Redcarpet::Render::HTML.new(prettify: true, no_styles: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, disable_indented_code_blocks: true)
  end

  def render(input)
    @markdown.render(input)
  end
end