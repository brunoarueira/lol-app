require './lib/env'
require './lib/league_of_legends'
require './config/unreloader'
require './config/league_of_legends'

Unreloader.require './lol.rb'

run(env.development? ? Unreloader : Lol::App.freeze.app)
