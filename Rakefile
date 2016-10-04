require "rake"
require "rake/clean"

namespace :assets do
  desc "Precompile the assets"
  task :precompile do
    require './lol'

    Lol::App.compile_assets
  end
end
