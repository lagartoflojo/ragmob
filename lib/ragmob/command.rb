module Ragmob
  module Command
    def get_api_info
      # TODO: Properly serialize the return data into domain objects.
      connection.get('api/command?action=get_api_info')
    end
  end
end
