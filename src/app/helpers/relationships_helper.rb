module RelationshipsHelper
  def follows?(follower_id, followee_id)
    Relationship.exists?(follower_id: follower_id, followee_id: followee_id)
  end
end
