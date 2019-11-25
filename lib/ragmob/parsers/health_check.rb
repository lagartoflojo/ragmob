require 'happymapper'

module Ragmob
  module Parsers
    class Appliance
      include HappyMapper

      tag 'appliance'

      attribute :id, String
      content :name, String
    end

    class IP
      include HappyMapper

      tag 'ip'

      content :ip, String
    end

    class HealthCheck
      include HappyMapper

      tag 'health_check'

      element :version, String
      element :failover_role, String
      element :success, String
      element :error_message, String
      element :last_data_sync_time, Time
      element :last_data_sync_status, String
      has_one :appliance, Appliance
      has_many :enabled_shared_ips, IP, tag: 'ip'

      def appliance_id
        appliance.id
      end

      def appliance_name
        appliance.name
      end

      def enabled_shared_ips
        @enabled_shared_ips.map(&:ip)
      end

      def success
        @success == '1'
      end
    end
  end
end
