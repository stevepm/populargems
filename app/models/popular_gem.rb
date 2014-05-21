class PopularGem < ActiveRecord::Base
  has_many :comments
  has_many :hearts
  validates :name, uniqueness: true
end
