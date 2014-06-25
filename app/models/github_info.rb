require "addressable/uri"

class GithubInfo
  class << self
    def gather(url, project_url = nil, source_code_url = nil)
      sleep 1
      home = Addressable::URI.parse(URI.encode(url)) if url
      source = Addressable::URI.parse(URI.encode(source_code_url)) if source_code_url
      project = Addressable::URI.parse(URI.encode(project_url)) if project_url
      info = nil
      if home && home.to_s.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(home)
      elsif source && source.to_s.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(source)
      elsif project && project.to_s.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
        info = get_info(project)
      end
      info
    end

    private

    def get_info(url)
      info = nil
      url_match = url.to_s.match(/^(?:https?:\/\/)?(?:www\.)?github.com\/([^\/]+)\/([^\/]+)/)
      username = url_match[1]
      repo = url_match[2]
      response = Faraday.get("https://api.github.com/repos/#{username}/#{repo}?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}")
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