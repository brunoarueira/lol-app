require 'redis'

module LeagueOfLegends
  class Cache
    TIME_TO_LIVE = 900

    def initialize(options = {})
      if !options.key?(:url)
        raise ArgumentError, "The url param must exist"
      end

      if !options.key?(:api_version)
        raise ArgumentError, "The api_version param must exist"
      end

      self.redis = ::Redis.new(url: options[:url])
      self.api_version = options[:api_version]
    end

    def exists?(resource)
      store_key = store_key(resource)

      redis.get(store_key) != nil
    end

    def get(resource)
      store_key = store_key(resource)

      return unless exists?(resource)

      redis.get(store_key)
    end

    def set(resource, response)
      store_key = store_key(resource)

      redis.setex store_key, TIME_TO_LIVE, response.to_json
    end

    protected

    attr_accessor :redis, :result, :api_version

    def store_key(resource)
      "#{resource}/#{api_version}"
    end
  end
end
