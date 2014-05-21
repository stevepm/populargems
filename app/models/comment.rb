class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :popular_gem

  def self.create_from_gem_page(params)
    create! do |comment|
      comment.body = ConvertFromMarkdown.new.render(params[:body])
      comment.user = User.find(params[:user])
      comment.popular_gem = PopularGem.find(params[:popular_gem])
    end
  end
end
