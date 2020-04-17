module FollowershipsHelper
  def follows?(followee)
    current_user.followings.exists?(followee: followee)
  end
end
