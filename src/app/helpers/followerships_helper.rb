module FollowershipsHelper
  def follows?(followee)
    Followership.exists?(follower: current_user, followee: followee)
  end
end
