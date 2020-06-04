module RecommendationsHelper
  MAX_USER_RECCOMMENDED_FUNCTIONS = 5

  module RecommendationsPartialPath
    def to_partial_path
      'recommendations/function'
    end
  end

  def more_from_user(user)
    most_liked = user.functions.order(likes_count: :desc).first
    most_commented = user.functions.order(comments_count: :desc).first
    most_saved = user.functions.order(saves_count: :desc).first

    [most_liked, most_saved, most_commented].uniq.map { |obj| obj.extend(RecommendationsPartialPath) }
  end
end
