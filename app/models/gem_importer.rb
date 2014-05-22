class GemImporter
  class << self
    def seed_db(name)
      new_gem = PopularGem.new(name: name)
      if new_gem.valid?
        response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
        if response.body == "This rubygem could not be found." || response.body == 'This gem does not exist.'
          puts "#{name} Gem does not exist"
        else
          body = JSON.parse(response.body)
          new_gem.update(total_downloads: body["downloads"])
          new_gem.update(version: body["version"])
          new_gem.update(version_downloads: body["version_downloads"])
          new_gem.update(url: body["project_uri"])
          new_gem.update(project_url: body["homepage_uri"])
          new_gem.update(description: body["info"])
        end
      end
    end

    def update_gem(name)
      gem = PopularGem.find_by_name(name)
      response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
      if response.body == "This rubygem could not be found."
        gem.errors.add(:name, "Gem does not exist")
      else
        body = JSON.parse(response.body)
        gem.update(total_downloads: body["downloads"])
        gem.update(version: body["version"])
        gem.update(version_downloads: body["version_downloads"])
        gem.update(url: body["project_uri"])
        gem.update(project_url: body["homepage_uri"])
        gem.update(description: body["info"])
      end
    end
  end
end