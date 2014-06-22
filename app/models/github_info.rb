class GithubInfo
  class << self
    def gather(gem)
      url = gem.project_url
      info = nil
      if url
        if url_match = url.match(/^(?:https?:\/\/)?(?:www.)?github.com\/(\w+)\/(.+)\/?/)
          username = url_match[1]
          repo = url_match[2]
          response = Faraday.get("https://api.github.com/repos/#{username}/#{repo}")
          if response.status >= 300
            false
          else
            json = JSON.parse(response.body)
            info = {
              stars: json["stargazers_count"],
              forks: json["forks"],
              issues: json["open_issues"],
              updated_at: json["updated_at"]
            }
          end
        end
      end
      info
    end
  end
end