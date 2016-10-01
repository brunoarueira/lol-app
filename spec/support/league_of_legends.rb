require 'league_of_legends'

LeagueOfLegends.config do |config|
  config.api_key = ENV['LOL_API_KEY']
  config.region = "euw"
end
