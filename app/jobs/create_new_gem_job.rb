class CreateNewGemJob
  include SuckerPunch::Job

  def perform(gem_name)
    puts "Starting #{gem_name}\n"
    ActiveRecord::Base.connection_pool.with_connection do
      ::GemImporter.seed_db(gem_name)
    end
    puts "Ending #{gem_name}\n"
  end

end