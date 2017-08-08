# frozen_string_literal: true

$redis = Redis::Namespace.new(Secret.redis.namespace, redis: Redis.new(Secret.redis.symbolize_keys))
