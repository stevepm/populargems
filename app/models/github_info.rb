class GithubInfo
  class << self
    def gather(gem)
      url = Addressable::URI.parse(URI.encode(gem.project_url)) if gem.project_url
      source = Addressable::URI.parse(URI.encode(gem.source_code_url)) if gem.source_code_url
      home = Addressable::URI.parse(URI.encode(gem.url)) if gem.url
      info = nil
      if url && gem.project_url.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(url)
      elsif source && gem.source_code_url.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(source)
      elsif home && gem.url.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(home)
      end
      info
    end

    private


    def get_info(url)
      info = nil
      url_match = url.path.match(/([^\/]+)\/([^\/]+)/)
      username = url_match[1]
      repo = url_match[2]
      response = Faraday.get("https://api.github.com/repos/#{username}/#{repo}")
      unless response.status >= 300
        json = JSON.parse(response.body)
        info = {
          stars: json["stargazers_count"],
          forks: json["forks"],
          issues: json["open_issues"],
          updated_at: json["pushed_at"]
        }
      end
      info
    end
  end
end