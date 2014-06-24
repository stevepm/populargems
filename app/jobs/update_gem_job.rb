class UpdateGemJob
  include SuckerPunch::Job

  def perform(gem)
    ActiveRecord::Base.connection_pool.with_connection do
      GemImporter.update_gem(gem.name)
    end
  end
end