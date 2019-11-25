require "spec_helper"

describe Ragmob::Parsers::HealthCheck do
  let(:xml) { load_fixture("check_health.xml") }

  it "parses the XML correctly" do
    health_check = Ragmob::Parsers::HealthCheck.parse(xml, single: true)

    _(health_check.appliance_id).must_equal "50adeb59f0f04163b09b7591af1949ea"
    _(health_check.appliance_name).must_equal "ip-10-156-1-1"
    _(health_check.version).must_equal '19.1.8 (37380-749b17ca33d2475427428f263608ae98d69f7a35)'
    _(health_check.failover_role).must_equal 'none'
    _(health_check.success).must_equal true
    _(health_check.enabled_shared_ips).must_equal %w[1.2.3.4 5.6.7.8]
    _(health_check.error_message).must_equal 'all is good'
    _(health_check.last_data_sync_time).must_equal Time.parse('2019-10-07T00:32:50.877+0000')
    _(health_check.last_data_sync_status).must_equal 'success'
  end
end
