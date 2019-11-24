$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require "ragmob"

require "minitest/autorun"
require "minitest/reporters"
require "minitest-spec-context"
require "webmock/minitest"
require "pry"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
WebMock.disable_net_connect!(allow_localhost: true)

def test_server_url
  'https://support.example.com'
end

def test_client_id
  'abcd'
end

def test_client_secret
  'gefj'
end
