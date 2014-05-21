class ConvertFromMarkdown
  def initialize
    renderer = Redcarpet::Render::HTML.new(filter_html: true, prettify: true, no_styles: true, filter_html: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def render(input)
    @markdown.render(input)
  end
end