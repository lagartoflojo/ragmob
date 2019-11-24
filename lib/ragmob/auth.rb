require "http"
require "json"
require "uri"

module Ragmob
  class Auth
    def initialize(server_url:, client_id:, client_secret:)
      self.server_url = server_url
      self.client_id = client_id
      self.client_secret = client_secret
    end

    def access_token
      return token if token_still_valid?

      response = fetch_access_token

      raise 'Wrong credentials' if response.code == 401

      json_response = JSON.parse(response.body.to_s)
      self.expires_at = Time.at(Time.new.to_i + json_response.fetch('expires_in'))
      self.token = json_response.fetch 'access_token'
    end

    private

    attr_accessor :server_url, :client_id, :client_secret, :token, :expires_at

    def token_still_valid?
      expires_at && Time.new < expires_at
    end

    def fetch_access_token
      HTTP
        .basic_auth(user: client_id, pass: client_secret)
        .post(URI.join(server_url, "oauth2/token"), form: { grant_type: "client_credentials" })
    end
  end
end
