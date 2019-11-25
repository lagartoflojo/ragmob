require "ragmob/parsers/api_information"

module Ragmob
  module Command
    def get_api_info
      resp = connection.get('api/command?action=get_api_info')
      Ragmob::Parsers::ApiInformation.parse(resp.body.to_s, single: true)
    end
  end
end
