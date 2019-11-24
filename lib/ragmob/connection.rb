require "http"
require "uri"
require "ragmob/auth"

module Ragmob
  class Connection
    def initialize(server_url:, client_id:, client_secret:)
      self.server_url = server_url
      self.auth = Ragmob::Auth.new(server_url: server_url, client_id: client_id, client_secret: client_secret)
    end

    def get(path, params: {})
      http.get(URI.join(server_url, path), params: params)
    end

    private

    attr_accessor :server_url, :auth

    def http
      HTTP.auth("Bearer #{auth.access_token}")
    end
  end
end
