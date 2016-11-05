require 'httparty'
require 'redis'

module LeagueOfLegends
  class NotFound < StandardError; end
  class TooManyRequests < StandardError; end

  class Request
    class << self
      def get(resource, additional_params = {})
        api_url = api_url(resource)
        store_key = store_key(resource)

        if result = store.get(store_key)
          return JSON.parse(result)
        end

        response = HTTParty.get(api_url, { query: additional_params })

        if response.respond_to?(:code) && !(200...300).include?(response.code)
          raise NotFound.new("404 Not Found") if response.not_found?
          raise TooManyRequests.new('429 Rate limit exceeded') if response.code == 429
          raise InvalidAPIResponse.new(api_url, response)
        end

        response = response.parsed_response

        store.setex store_key, 900, response.to_json

        response
      end

      private

      def api_url(resource)
        LeagueOfLegends.generate_url_to_call(resource)
      end

      def store_key(resource)
        "#{resource}/#{api_version}"
      end

      def api_version
        LeagueOfLegends.api_version
      end

      def store
        LeagueOfLegends.store
      end
    end
  end
end
