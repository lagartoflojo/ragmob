require "ragmob/connection"
require "ragmob/command"

module Ragmob
  class Client
    include Ragmob::Command

    def initialize(server_url:, client_id:, client_secret:)
      self.connection = Ragmob::Connection.new(server_url: server_url, client_id: client_id, client_secret: client_secret)
    end

    private

    attr_accessor :connection
  end
end
