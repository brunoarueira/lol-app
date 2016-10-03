require 'capybara/rspec'
require 'capybara/webkit'

Capybara.configure do |config|
  config.default_driver = :webkit
  config.match = :prefer_exact
  config.app = Lol::App.app
end

Capybara.register_driver :webkit do |app|
  options = {
    #The dimensions of the browser window in which to test, expressed as a 2-element array,
    window_size: [1280, 800]
  }

  Capybara::Webkit::Driver.new(app, options)
end

Capybara::Webkit.configure do |config|
  config.allow_url("ddragon.leagueoflegends.com")
end
