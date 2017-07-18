module RedisCacheService

  def self.cache_hash(key, expires_time=1.day)
    return $redis.hgetall(key) if $redis.hgetall(key).any?

    hash = yield
    hash.each do |index, external_id|
      $redis.hset(key, index, external_id)
      $redis.expire(key, expires_time)
    end
    hash
  end

  def self.cache_integer(key, expires_time=1.day)
    return $redis.get(key).to_i if $redis.get(key).present?
    integer = yield
    $redis.set(key, integer)
    $redis.expire(key, expires_time)
    integer
  end

end
