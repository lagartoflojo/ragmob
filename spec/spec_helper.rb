$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require "ragmob"

require "minitest/autorun"
require "minitest/reporters"
require "minitest-spec-context"
require "webmock/minitest"
require "pry"
require "vcr"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { record: :once }

  config.before_record do |i|
    i.request.headers.delete('Authorization')
  end

  config.filter_sensitive_data("<SERVER_HOST>") do
    URI.parse(test_server_url).host
  end

  config.filter_sensitive_data("<CLIENT_ID>") do
    test_client_id
  end

  config.filter_sensitive_data("<CLIENT_SECRET>") do
    test_client_secret
  end
end

def test_server_url
  ENV.fetch 'RAGMOB_TEST_SERVER_URL', 'https://support.example.com'
end

def test_client_id
  ENV.fetch 'RAGMOB_TEST_CLIENT_ID', 'my-precious-client-id'
end

def test_client_secret
  ENV.fetch 'RAGMOB_TEST_CLIENT_SECRET', 'my-delicious-client-secret'
end
