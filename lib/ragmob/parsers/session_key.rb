require 'happymapper'

module Ragmob
  module Parsers
    class Queue
      include HappyMapper

      tag 'queue'

      content :name, String
      attribute :available, Boolean
    end

    class SessionKey
      include HappyMapper

      tag 'session_key'

      element :type, String
      element :ttl, Integer
      element :expires, Time
      element :queue, Queue
      element :queue_id, Integer
      element :external_key, String
      element :short_key, String
      element :key_url, String
      element :mail_subject, String
      element :mail_body, String

      def queue_name
        @queue.name
      end

      def queue_available
        @queue.available
      end
    end
  end
end
