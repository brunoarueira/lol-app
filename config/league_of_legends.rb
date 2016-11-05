LeagueOfLegends.config do |config|
  config.api_key = ENV.fetch('LOL_API_KEY')
  config.api_version = ENV.fetch('LOL_API_VERSION')
  config.region = ENV.fetch('LOL_REGION', 'euw')
  config.redis_url = ENV.fetch('REDIS_PROVIDER', 'redis://localhost:6379/')
end
