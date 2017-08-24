# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = Secret.sidekiq_redis.symbolize_keys
end

Sidekiq.configure_client do |config|
  config.redis = Secret.sidekiq_redis.symbolize_keys
end
