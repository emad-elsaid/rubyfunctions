module SentryConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_raven_context
  end

  private

  def set_raven_context
    return unless current_user

    Raven.user_context(user: current_user.username)
  end
end
