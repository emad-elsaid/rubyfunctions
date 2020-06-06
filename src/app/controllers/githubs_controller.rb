class GithubsController < ApplicationController
  rescue_from RestClient::Unauthorized, with: :unauthorized

  def new
    user = User.find_or_create_from_github_user(github_user)
    session[:user] = user.id
    redirect_back(fallback_location: root_path, allow_other_host: false)
  end

  private

  def github_user
    JSON.parse(
      RestClient.get(
        'https://api.github.com/user',
        Authorization: "Bearer #{access_token}"
      )
    )
  end

  def access_token
    access_token_response = RestClient.post(
      'https://github.com/login/oauth/access_token',
      {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET'],
        code: params[:code]
      },
      accept: :json
    )
    JSON.parse(access_token_response)['access_token']
  end

  def unauthorized
    redirect_to root_path, alert: 'Github returned Unauthorized error when trying to log you in, please try again'
  end
end
