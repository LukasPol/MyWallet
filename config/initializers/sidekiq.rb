require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(username, ENV['SIDEKIQ_USERNAME']) &
    ActiveSupport::SecurityUtils.secure_compare(password, ENV['SIDEKIQ_PASSWORD'])
end

Sidekiq.configure_server do |config|
  config.redis = { url: (ENV['REDIS_URL']).to_s }
end

Sidekiq.configure_client do |config|
  config.redis = { url: (ENV['REDIS_URL']).to_s }
end

Rails.application.config.cache_store = :redis_cache_store, {
  url: ENV['REDIS_URL'],
  network_timeout: 5
}

Rails.application.config.active_job.queue_adapter = :sidekiq
