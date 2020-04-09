module SavesHelper
  def saved?(user, function)
    user.saves.exists?(function: function)
  end
end
