require 'happymapper'

module Ragmob
  module Parsers
    class Permission
      include HappyMapper

      tag 'permission'

      attribute :name, String
      content :value, String

      def value
        return true if @value == '1'
        return false if @value == '0'

        @value
      end
    end

    class ApiInformation
      include HappyMapper

      tag 'api_information'

      element :api_version, String
      element :company_name, String
      element :timestamp, Integer
      has_many :permissions, Permission, tag: 'permission'

      def timestamp
        Time.at @timestamp
      end

      def permissions
        @permissions.each_with_object({}) do |perm, memo|
          memo[perm.name] = perm.value
          memo
        end
      end
    end
  end
end
