require "ragmob/parsers/api_information"
require "ragmob/parsers/health_check"
require "ragmob/parsers/session_key"

module Ragmob
  module Command
    def get_api_info
      resp = connection.get('api/command?action=get_api_info')
      Ragmob::Parsers::ApiInformation.parse(resp.body.to_s, single: true)
    end

    def check_health
      resp = connection.get('api/command?action=check_health')
      Ragmob::Parsers::HealthCheck.parse(resp.body.to_s, single: true)
    end
  end
end
