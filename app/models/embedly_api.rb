require 'embedly'

class EmbedlyApi
  attr_reader :url

  def initialize(url)
    @url = url
    embedly_api = Embedly::API.new :key => ENV['EMBEDLY'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    @obj = embedly_api.oembed :url => @url, maxwidth: 500
  end

  def output
    return_string = url
    if @obj.first.provider_name == 'Imgur'
      return_string = "<img src=#{@obj.first.thumbnail_url}>"
    elsif @obj.first.provider_name == 'GitHub' || @obj.first.provider_name == 'YouTube'
      return_string = @obj.first.html
    end
    return_string
  end
end