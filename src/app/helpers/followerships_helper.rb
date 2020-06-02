module FollowershipsHelper
  def follows?(followee)
    current_user.following_followerships.exists?(followee: followee)
  end
end
