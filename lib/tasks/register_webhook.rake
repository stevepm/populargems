include Rails.application.routes.url_helpers

desc('fire a test webhook')
task 'webhook:fire' => :environment do
  puts `curl -H 'Authorization:#{ENV['RUBYGEMS_API']}' -F 'gem_name=*' -F 'url=#{receive_data_url host: ENV['SITE_URL']}' https://rubygems.org/api/v1/web_hooks/fire`
end

desc('register a webhook with rubygems')
task 'webhook:register' => :environment do
  puts `curl -H 'Authorization:#{ENV['RUBYGEMS_API']}' -F 'gem_name=*' -F 'url=#{receive_data_url host: ENV['SITE_URL']}' https://rubygems.org/api/v1/web_hooks`
end

desc('unregister a webhook from rubygems')
task 'webhook:unregister' => :environment do
  puts `curl -X DELETE -H 'Authorization:#{ENV['RUBYGEMS_API']}' -F 'gem_name=*' -F 'url=#{receive_data_url host: ENV['SITE_URL']}' https://rubygems.org/api/v1/web_hooks/remove`
end
