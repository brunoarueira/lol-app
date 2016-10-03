require 'rubygems'
require 'roda'

require ::File.expand_path('../lib/league_of_legends',  __FILE__)

LeagueOfLegends.config do |config|
  config.api_key = ENV['LOL_API_KEY']
  config.region = "euw"
end

module Lol
  class App < Roda
    opts[:root] = File.dirname(__FILE__)

    plugin :public, gzip: true
    plugin :render, escape: true
    plugin :assets,
        css: %w'bootstrap.min.css application.scss',
        css_opts: { style: :compressed, cache: false },
        css_dir: nil,
        compiled_path: nil,
        compiled_css_dir: nil,
        precompiled: File.expand_path('../compiled_assets.json', __FILE__),
        prefix: nil,
        gzip: true
    plugin :error_handler
    plugin :not_found

    error do |e|
      $stderr.puts e.message

      e.backtrace.each do |x|
        $stderr.puts x
      end

      view content: "<h3>Oops, an error occurred.</h3>"
    end

    not_found do
      view content: "<h3>The page you are looking for does not exist.</h3>"
    end

    route do |r|
      r.public
      r.assets

      r.root do
        @champions = LeagueOfLegends::Champion.all

        view 'index'
      end

      r.is 'search' do
        query = request['q']

        if query && query.empty?
          view content: "<h3>You must need to type in a text to search"
        else
          @champions = LeagueOfLegends::Champion.search_by(query)

          view 'index'
        end
      end

      r.is 'champion/:id' do |id|
        @champion = LeagueOfLegends::Champion.find(id)

        if @champion
          view 'champion'
        else
          nil
        end
      end
    end
  end
end
