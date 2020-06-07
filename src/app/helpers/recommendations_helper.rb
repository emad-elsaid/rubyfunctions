module RecommendationsHelper
  MAX_RECOMMENDED_FUNCTIONS = 5

  module RecommendationsPartialPath
    def to_partial_path
      'recommendations/function'
    end
  end

  def more_from_user_function(function)
    most_liked = user_most_function function.user, likes_count: :desc
    most_commented = user_most_function function.user, comments_count: :desc
    most_saved = user_most_function function.user, saves_count: :desc

    recommended_functions = filter_unwanted [most_liked, most_commented, most_saved], function
    override_partial_path recommended_functions, RecommendationsPartialPath
  end

  def similar_functions(function)
    popularity_query = generate_popularity_query

    popular_functions_from_tags = function.tags.map { |tag| tag.functions.order(popularity_query).first }
    popular_functions = Function.order(Arel.sql(popularity_query))
                                .limit(MAX_RECOMMENDED_FUNCTIONS - popular_functions_from_tags.count)

    recommended_functions = filter_unwanted [*popular_functions_from_tags, *popular_functions], function
    override_partial_path recommended_functions, RecommendationsPartialPath
  end

  private

  def override_partial_path(functions, partial_path_module)
    functions.map { |obj| obj.extend(partial_path_module) }
  end

  def generate_popularity_query
    likes_wieght = 1
    comments_weight = 0.5
    saves_weight = 0.25

    "( (likes_count * #{likes_wieght}) + (comments_count * #{comments_weight}) + (saves_count * #{saves_weight}) ) desc"
  end

  # Returns the most x function for a certain user
  # based on a criteria defined in `parameter`.
  #
  # @param user [User]
  # @param parameter [Hash]
  # @returns [Function]
  def user_most_function(user, parameter)
    user.functions.order(parameter).first
  end

  # Filters an array of Functions. It removes an `unwated_function`
  # and any `nil` variables in the `functions` array.
  #
  # @param functions [Array<Function>]
  #
  # @param unwanted_functon [Function] a function to be filtered
  # out of the Functions array.
  #
  # @returns [Array<Function>]
  def filter_unwanted(functions, unwanted_function)
    functions.reject { |func| func.nil? || func == unwanted_function }.uniq
  end
end
