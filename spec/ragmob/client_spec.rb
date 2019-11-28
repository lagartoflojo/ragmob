require "spec_helper"

describe Ragmob::Client do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  let(:client) { Ragmob::Client.new(server_url: test_server_url, client_id: test_client_id, client_secret: test_client_secret) }

  describe '#get_api_info' do
    subject { client.get_api_info }

    it "returns info about the API" do
      _(subject).must_be_instance_of Ragmob::Parsers::ApiInformation
      _(subject.company_name).must_equal 'supportsuse'
    end
  end

  describe '#check_health' do
    subject { client.check_health }

    it "returns the health of the appliance" do
      _(subject).must_be_instance_of Ragmob::Parsers::HealthCheck
      _(subject.appliance_id).must_equal '50adeb59f0f04163b09b7591af1949ea'
    end
  end

  describe '#generate_session_key' do
    subject { client.generate_session_key(params) }

    context "when queue_id is general" do
      let(:params) { { queue_id: 'general' } }

      it "generates a session key for the general queue" do
        _(subject).must_be_instance_of Ragmob::Parsers::SessionKey
        _(subject.queue_name).must_equal 'general'
      end
    end

    context "when queue_id is a rep" do
      let(:params) { { queue_id: 'rep:1' } }

      it "generates a session key for the rep" do
        _(subject).must_be_instance_of Ragmob::Parsers::SessionKey
        _(subject.queue_name).must_equal 'rep'
        _(subject.queue_id).must_equal 1
      end
    end

    context "when an external key is passed" do
      let(:params) { { queue_id: 'general', 'session.custom.external_key' => '1234' } }

      it "generates a session key for the given external key" do
        _(subject).must_be_instance_of Ragmob::Parsers::SessionKey
        _(subject.queue_name).must_equal 'general'
        _(subject.external_key).must_equal '1234'
      end
    end
  end
end
