class PopularGem < ActiveRecord::Base
  has_many :comments
  validates :name, uniqueness: true

  validate :gather_information

  def gather_information
    response = Faraday.get "https://rubygems.org/api/v1/gems/#{name}.json"
    if response.body == "This rubygem could not be found."
      errors.add(:name, "Gem does not exist")
    else
      body = JSON.parse(response.body)
      self.name = body["name"]
      self.total_downloads = body["downloads"]
      self.version = body["version"]
      self.version_downloads = body["version_downloads"]
      self.url = body["project_uri"]
      self.project_url = body["homepage_uri"]
      self.description = body["info"]
    end
  end
end
