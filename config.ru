require './lib/env'
require './config/unreloader'

Unreloader.require './lol.rb'

run(env.development? ? Unreloader : Lol::App.freeze.app)
