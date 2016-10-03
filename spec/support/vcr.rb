require "vcr"
require "webmock/rspec"

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path("../../fixtures/vcr_cassettes", __FILE__)
  c.hook_into :webmock

  c.default_cassette_options = {
    allow_playback_repeats: true,
    record: :new_episodes,
    serialize_with: :yaml
  }

  c.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding.name == 'ASCII-8BIT' ||
    !http_message.body.valid_encoding?
  end

  c.ignore_request do |request|
    uri = URI(request.uri)

    (uri.port != 80 && uri.host == "localhost") || (uri.host == "127.0.0.1")
  end

  c.configure_rspec_metadata!
end
