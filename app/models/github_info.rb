class GithubInfo
  class << self
    def gather(gem)
      url = gem.project_url
      source = gem.source_code_url
      info = nil
      if url && url.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(url)
      elsif source && source.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(source)
      end
      info
    end

    private

    def get_info(url)
      info = nil
      url_match = url.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
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