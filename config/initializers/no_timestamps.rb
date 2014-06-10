class ActiveRecord::Base
  def self.without_timestamps
    self.record_timestamps = false
    yield
  ensure
    self.record_timestamps = true
  end
end