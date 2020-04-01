module ApplicationHelper
  def title
    Array(content_for(:title)).prepend('Ruby Functions').flatten().join(' - ')
  end
end
