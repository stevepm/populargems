class UpdateGemJob
  include SuckerPunch::Job

  def perform(gem)
    puts "Starting #{gem.name}\n"
    ActiveRecord::Base.connection_pool.with_connection do
      ::PopularGem.without_timestamps do
        ::GemImporter.update_gem(gem.name)
      end
    end
    puts "Ending #{gem.name}\n"
  end

  def later(sec, data)
    after(sec) { perform(data) }
  end

end