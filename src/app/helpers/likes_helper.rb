module LikesHelper
  def liked?(function, user)
    Like.exists?(user: user, likeable: function)
  end
end
