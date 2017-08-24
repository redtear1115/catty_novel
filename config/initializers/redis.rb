# frozen_string_literal: true

$redis = Redis::Namespace.new(Secret.cache_redis.namespace, redis: Redis.new(Secret.cache_redis.symbolize_keys))
