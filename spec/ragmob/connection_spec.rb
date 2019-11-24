require 'spec_helper'

describe Ragmob::Connection do
  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  let(:connection) { Ragmob::Connection.new(server_url: test_server_url, client_id: test_client_id, client_secret: test_client_secret) }

  describe '#get' do
    it 'makes an authenticated GET request' do
      response = connection.get('api/command?action=get_api_info')
      _(response.status).must_be :success?
      _(response.body.to_s).must_match(/api_information/)
    end

    it 'makes a request with the given params' do
      response = connection.get('api/command?action=generate_session_key', params: { type: 'support', queue_id: 'general' })
      _(response.status).must_be :success?
      _(response.body.to_s).must_match(/session_key/)
    end
  end
end
