module LeagueOfLegends
  class << self
    attr_accessor :api_key, :api_url, :api_version, :redis_url, :region

    def cache
      Cache.new(url: LeagueOfLegends.redis_url, api_version: self.api_version)
    end

    def config
      yield self
    end
  end

  self.api_key = nil
  self.api_url = nil
  self.api_version = nil
  self.redis_url = nil
  self.region = nil
end

require_relative 'league_of_legends/invalid_api_response'
require_relative 'league_of_legends/request'
require_relative 'league_of_legends/cache'
require_relative 'league_of_legends/champion'
require_relative 'league_of_legends/game_version'
require_relative 'league_of_legends/item'
