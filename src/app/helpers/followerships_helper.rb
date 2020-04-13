module FollowershipsHelper
  def follows?(follower_id, followee_id)
    Followership.exists?(follower_id: follower_id, followee_id: followee_id)
  end
end
