require_relative 'league_of_legends/invalid_api_response'
require_relative 'league_of_legends/request'
require_relative 'league_of_legends/champion'
require_relative 'league_of_legends/game_version'
require_relative 'league_of_legends/item'

module LeagueOfLegends
  API_URL = "https://global.api.pvp.net/api/lol/static-data"

  class << self
    attr_accessor :api_key, :region

    def generate_url_to_call(resource, api_version)
      "#{API_URL}/#{self.region}/#{api_version}/#{resource}?api_key=#{self.api_key}"
    end
  end

  self.api_key = nil
  self.region = nil

  def self.config
    yield self
  end
end
