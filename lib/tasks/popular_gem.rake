namespace :gem do
  desc('set featured gems')
  task :featured, [:gem1, :gem2, :gem3, :gem4, :gem5, :gem6, :gem7, :gem8, :gem9, :gem10] => :environment do |t, args|
    PopularGem.where(featured: true).each { |gem| gem.update_column(:featured, false) }
    args.each do |k, gem|
      PopularGem.find_by_name("#{gem}").update_column(:featured, true)
    end
  end

  desc('Update all gems')
  task :update_all => :environment do
    require_dependency 'github_info'
    PopularGem.where(gh_stars: nil).where("updated_at < ?", 1.day.ago).each do |gem|
      PopularGem.without_timestamps do
        GemImporter.update_gem(gem.name)
      end
    end
  end

  desc('Update score for all gems')
  task :set_score => :environment do
    PopularGem.all.each do |gem|
      PopularGem.without_timestamps do
        puts "Setting score for #{gem.name}"
        gem.set_score
      end
    end
  end

  desc('Add recently updated and created at stats')
  task :set_stats => :environment do
    puts 'Created stat logs'
    PopularGem.create_stat_logs
  end
end