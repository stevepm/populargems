desc('set featured gems')
task 'gem:featured', [:gem1, :gem2, :gem3, :gem4, :gem5, :gem6, :gem7, :gem8, :gem9, :gem10] => :environment do |t, args|
  PopularGem.where(featured: true).destroy_all
  args.each do |k, gem|
    PopularGem.find_by_name("#{gem}").update_column(:featured, true)
  end
end