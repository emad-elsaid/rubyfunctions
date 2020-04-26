require 'rails_helper'

RSpec.describe GithubsController do
  let(:access_token_resp) do
    { access_token: 'e72e16c7e42f292c6912e7710c838347ae178b4a' }
  end

  let(:github_user_resp) do
    {
      id: 1,
      name: 'doctor manhattan',
      login: 'drmanhattan'
    }
  end

  before do
    stub_request(:post, 'https://github.com/login/oauth/access_token')
      .to_return(body: access_token_resp.to_json)

    stub_request(:get, 'https://api.github.com/user')
      .to_return(body: github_user_resp.to_json)
  end

  context 'POST #new' do
    it 'Creates a new user' do
      expect { post :new }.to change(User, :count).by(1)
    end
  end
end
