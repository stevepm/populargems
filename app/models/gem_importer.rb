class GemImporter
  class << self
    def seed_db(name)
      new_gem = PopularGem.new(name: name)
      if new_gem.valid?
        response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
        if response.body == "This rubygem could not be found." || response.body == 'This gem does not exist.'
          false
        else
          puts "Gather data for #{name}....."
          body = JSON.parse(response.body)
          new_gem.update(total_downloads: body["downloads"])
          new_gem.update(version: body["version"])
          new_gem.update(version_downloads: body["version_downloads"])
          new_gem.update(url: body["project_uri"])
          new_gem.update(project_url: body["homepage_uri"])
          new_gem.update(description: body["info"])
          new_gem
        end
      end
    end

    def update_gem(name)
      response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
      if response.body == "This rubygem could not be found." || response.body == 'This gem does not exist.'
        puts "#{name} Gem does not exist"
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