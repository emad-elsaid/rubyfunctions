module UsersHelper
  def user_image_url(user)
    "https://avatars0.githubusercontent.com/u/#{user.github_id}?v=4"
  end

  def user_github_url(user)
    "https://github.com/#{user.username}"
  end

  def show_actions?
    page_title = content_for(:title).to_param
    page_title && !page_title.include?("Followers")
  end
end
