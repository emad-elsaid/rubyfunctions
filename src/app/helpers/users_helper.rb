module UsersHelper
  def user_image_url(user)
    "https://avatars0.githubusercontent.com/u/#{user.github_id}?v=4"
  end
end
