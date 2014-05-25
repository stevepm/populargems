class GemImporter
  class << self
    def seed_db(name)
      if (new_gem = PopularGem.new(name: name)).valid?
        response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
        if response.status >= 300
          false
        else
          puts "Gather data for #{name}....."
          update_info(JSON.parse(response.body), new_gem)
          new_gem
        end
      end
    end

    def update_gem(name)
      response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
      if response.status >= 300
        false
      else
        update_info(JSON.parse(response.body), PopularGem.find_by_name(name))
      end
    end

    private

    def update_info(body, gem)
      gem.update(total_downloads: body["downloads"],
                 version: body["version"],
                 version_downloads: body["version_downloads"],
                 url: body["project_uri"],
                 project_url: body["homepage_uri"],
                 description: body["info"])
    end
  end
end