require "#{Rails.root}/app/models/popular_gem"

desc('gather top downloaded gems')
task 'gem:downloaded' do
  PopularGem.top_downloaded(10)
end