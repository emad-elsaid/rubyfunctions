module FollowershipsHelper
  def follows?(follower, followee)
    Followership.exists?(follower: follower, followee: followee)
  end
end
