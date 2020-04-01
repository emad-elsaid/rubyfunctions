module ApplicationHelper
  def title
    if content_for?(:title)
      "Ruby Functions - " + (content_for :title)
    else
      "Ruby Functions"
    end
  end
end
