class PopularGem < ActiveRecord::Base
  has_many :comments
  validates :name, uniqueness: true
end
