module ElementsHelper
  def icon(class_name)
    tag.span tag.i(class: class_name), class: :icon
  end
end
