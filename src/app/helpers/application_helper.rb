module ApplicationHelper
  def title
    if content_for?(:title)
      (content_for :title).prepend("Ruby Functions - ")
    else
      "Ruby Functions"
    end
  end
end
