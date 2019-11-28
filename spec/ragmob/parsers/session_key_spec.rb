require "spec_helper"

describe Ragmob::Parsers::SessionKey do
  let(:xml) { load_fixture("generate_session_key.xml") }

  it "parses the XML correctly" do
    session_key = Ragmob::Parsers::SessionKey.parse(xml, single: true)

    _(session_key.type).must_equal 'support'
    _(session_key.ttl).must_equal 3600
    _(session_key.expires).must_equal Time.at(1_575_042_838)
    _(session_key.queue_name).must_equal 'general'
    _(session_key.queue_available).must_equal false
    _(session_key.queue_id).must_equal 1
    _(session_key.external_key).must_equal '1234'
    _(session_key.short_key).must_equal '789456'
    _(session_key.key_url).must_equal 'https://support.example.com/?ak=53484e6bdf9866e852a9eaf906c07ccf'
    _(session_key.mail_subject).must_equal 'Remote Support Invitation'
    _(session_key.mail_body).must_match(/Click on the link below./)
  end
end
