class User < ActiveRecord::Base
  has_many :comments
  has_many :hearts

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['extra']['raw_info']['login']
    end
  end
end
