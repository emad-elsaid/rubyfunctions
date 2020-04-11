module TimelinesHelper
  def achievement(done, label)
    icn = done ? icon('fas fa-check-circle') : icon('far fa-circle')
    tag.li icn + label, class: ('has-text-success' if done)
  end
end
