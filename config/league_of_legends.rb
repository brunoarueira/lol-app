LeagueOfLegends.config do |config|
  config.api_key = ENV.fetch('LOL_API_KEY')
  config.region = "euw"
  config.redis_url = ENV.fetch('REDIS_PROVIDER', 'redis://localhost:6379/')
end
