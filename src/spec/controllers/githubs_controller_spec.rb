require 'rails_helper'

RSpec.describe GithubsController do
  before do
    access_token_resp = '{"access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a",
    "scope":"repo,gist", "token_type":"bearer"}'
    # https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
    stub_request(:post, 'https://github.com/login/oauth/access_token')
      .to_return(body: access_token_resp)

    stub_request(:get, 'https://api.github.com/user')
      .to_return(body: '{"id": 1, "name": "doctor manhattan", "login": "drmanhattan"}')
  end

  context 'POST #new' do
    it 'Ceates a new user' do
      expect do
        post :new
      end.to change(User, :count).by(1)
    end
  end
end
