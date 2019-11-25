require "spec_helper"

describe Ragmob::Parsers::ApiInformation do
  let(:xml) { load_fixture("get_api_info.xml") }

  it "parses the XML correctly" do
    api_information = Ragmob::Parsers::ApiInformation.parse(xml, single: true)

    _(api_information.api_version).must_equal '1.19.0'
    _(api_information.company_name).must_equal 'supportsuse'
    _(api_information.timestamp).must_equal Time.at(1_574_638_362)
    _(api_information.permissions).must_equal(
      "perm_command" => "full_access",
      "perm_reporting_support" => true,
      "perm_reporting_presentation" => true,
      "perm_reporting_license" => true,
      "perm_reporting_archive" => true,
      "perm_real_time_state" => false,
      "perm_ecm" => false,
      "perm_backup" => false,
      "perm_scim" => false
    )
  end
end
