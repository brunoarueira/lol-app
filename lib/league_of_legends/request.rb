require 'httparty'

module LeagueOfLegends
  class NotFound < StandardError; end
  class TooManyRequests < StandardError; end

  class Request
    class << self
      def get(resource, api_version, additional_params = {})
        api_url = api_url(resource, api_version)

        response = HTTParty.get(api_url, { query: additional_params })

        if response.respond_to?(:code) && !(200...300).include?(response.code)
          raise NotFound.new("404 Not Found") if response.not_found?
          raise TooManyRequests.new('429 Rate limit exceeded') if response.code == 429
          raise InvalidAPIResponse.new(api_url, response)
        end

        response.parsed_response
      end

      private

      def api_url(resource, api_version)
        LeagueOfLegends.generate_url_to_call(resource, api_version)
      end
    end
  end
end
