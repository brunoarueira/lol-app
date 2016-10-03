require 'rack/unreloader'

Unreloader = Rack::Unreloader.new(reload: env.development?,
                                  subclasses: %w'Roda'){ Lol::App }
