module SavesHelper
  def saved?(function, user)
    user.saves.exists?(function: function)
  end
end
