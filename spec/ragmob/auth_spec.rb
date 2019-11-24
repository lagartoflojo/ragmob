require "spec_helper"

describe Ragmob::Auth do
  describe '#access_token' do
    let(:auth) { Ragmob::Auth.new(server_url: 'https://support.example.com', client_id: client_id, client_secret: client_secret) }
    def subject
      auth.access_token
    end

    context "with valid credentials" do
      let(:client_id) { 'abcd' }
      let(:client_secret) { 'gefj' }
      let(:request) do
        stub_request(:post, %r{/oauth2/token})
          .with(
            body: { grant_type: "client_credentials" },
            basic_auth: [client_id, client_secret]
          )
          .to_return(body: '{"access_token":"letoken","token_type":"Bearer","expires_in":3600}').then
          .to_return(body: '{"access_token":"anewtoken","token_type":"Bearer","expires_in":3600}') # This should not get called
      end

      before do
        request
      end

      it 'retrieves an access token' do
        _(subject).must_equal 'letoken'
      end

      context "calling it again before the token expires" do
        it "does not request a new token" do
          _(subject).must_equal 'letoken'
          _(subject).must_equal 'letoken'
          assert_requested(request, times: 1)
        end
      end

      context "calling it again after the token expires" do
        let(:request) do
          stub_request(:post, %r{/oauth2/token})
            .with(
              body: { grant_type: "client_credentials" },
              basic_auth: [client_id, client_secret]
            )
            .to_return(body: '{"access_token":"letoken","token_type":"Bearer","expires_in":0}').then
            .to_return(body: '{"access_token":"anewtoken","token_type":"Bearer","expires_in":0}')
        end

        it "requests a new token" do
          _(subject).must_equal 'letoken'
          _(subject).must_equal 'anewtoken'
          assert_requested(request, times: 2)
        end
      end
    end

    context "with invalid credentials" do
      let(:client_id) { "wrongid" }
      let(:client_secret) { "wrongsecret" }

      before do
        stub_request(:post, %r{/oauth2/token})
          .with(
            body: { grant_type: "client_credentials" },
            basic_auth: [client_id, client_secret]
          )
          .to_return(body: '{"error":"invalid_client","message":"Client authentication failed."}', status: 401)
      end

      it "raises an error" do
        _(proc { subject }).must_raise StandardError
      end
    end
  end
end
