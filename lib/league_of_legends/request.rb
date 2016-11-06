require 'httparty'

module LeagueOfLegends
  class NotFound < StandardError; end
  class TooManyRequests < StandardError; end

  class Request
    include ::HTTParty

    def initialize
      self.options = {
        query: { api_key: LeagueOfLegends.api_key }, verify: true
      }
    end

    def self.get_by_resource(resource, additional_params = {})
      self.base_uri LeagueOfLegends.api_url

      new.get_by_resource(resource, additional_params)
    end

    def get_by_resource(resource, additional_params = {})
      self.options[:query].merge!(additional_params)

      if cache.exists?(resource)
        return JSON.parse(cache.get(resource))
      end

      path = path(resource)

      response = self.class.get(path, options)

      if response.respond_to?(:code) && !(200...300).include?(response.code)
        raise NotFound.new("404 Not Found") if response.not_found?
        raise TooManyRequests.new('429 Rate limit exceeded') if response.code == 429
        raise InvalidAPIResponse.new(api_url, response)
      end

      response = response.parsed_response

      cache.set resource, response

      response
    end

    protected

    attr_accessor :options

    private

    def path(resource)
      @path ||= "/#{region}/#{api_version}/#{resource}"
    end

    def api_version
      LeagueOfLegends.api_version
    end

    def region
      LeagueOfLegends.region
    end

    def cache
      LeagueOfLegends.cache
    end
  end
end
