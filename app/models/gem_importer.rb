class GemImporter
  class << self
    def seed_db(name)
      if (new_gem = PopularGem.new(name: name)).valid?
        response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
        if response.status >= 300
          false
        else
          puts "Gather data for #{name}....."
          body = JSON.parse(response.body)
          new_gem.update(total_downloads: body["downloads"],
                 version: body["version"],
                 version_downloads: body["version_downloads"],
                 url: body["project_uri"],
                 project_url: body["homepage_uri"],
                 description: body["info"])
          new_gem
        end
      end
    end

    def update_gem(name)
      response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
      if response.status >= 300
        false
      else
        body = JSON.parse(response.body)
        PopularGem.find_by_name(name).update(total_downloads: body["downloads"],
                                                   version: body["version"],
                                                   version_downloads: body["version_downloads"],
                                                   url: body["project_uri"],
                                                   project_url: body["homepage_uri"],
                                                   description: body["info"])
      end
    end
  end
end