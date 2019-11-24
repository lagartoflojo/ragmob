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
      resp = subject
      _(resp.status).must_be :success?
    end
  end
end
