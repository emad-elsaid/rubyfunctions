class GithubsController < ApplicationController
  rescue_from RestClient::Unauthorized, with: :unauthorized

  def new
    access_token_response = RestClient.post(
      'https://github.com/login/oauth/access_token',
      {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET'],
        code: params[:code]
      },
      accept: :json
    )
    access_token = JSON.parse(access_token_response)['access_token']

    github_user_response = RestClient.get(
      'https://api.github.com/user',
      Authorization: "Bearer #{access_token}"
    )
    github_user = JSON.parse(github_user_response)

    user = User.find_or_create_by!(github_id: github_user['id']) do |new_user|
      username = github_user['login']
      new_user.username = User.exists?(github_id: username) ? SecureRandom.uuid : username
      new_user.name = github_user['name']
    end

    session[:user] = user.id
    redirect_to root_path
  end

  private

  def unauthorized
    redirect_to root_path, alert: 'Github returned Unauthorized error when trying to log you in, please try again'
  end
end
