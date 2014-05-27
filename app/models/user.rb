class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_merit
  acts_as_voter

  has_many :comments

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['extra']['raw_info']['login']
    end
  end
end