class UpdateGemJob
  include SuckerPunch::Job

  def perform(gem)
    ActiveRecord::Base.connection_pool.with_connection do
      PopularGem.without_timestamps do
        GemImporter.update_gem(gem.name)
      end
    end
  end
end