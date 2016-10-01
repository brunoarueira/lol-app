require 'roda'

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
        view 'index'
      end
    end
  end
end
