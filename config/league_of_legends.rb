LeagueOfLegends.config do |config|
  config.api_key = ENV['LOL_API_KEY']
  config.region = "euw"
  config.redis_url = ENV['REDIS_PROVIDER'] || 'redis://localhost:6379/'
end
