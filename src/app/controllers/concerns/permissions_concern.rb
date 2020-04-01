module PermissionsConcern
  extend ActiveSupport::Concern

  class Unauthorized < StandardError; end
  class ObjectPermissionsMissing < StandardError; end

  included do
    helper_method :can?
  end

  def can?(user, model, action)
    case model
    when Function then function_can?(user, model, action)
    when Comment then comment_can?(user, model, action)
    else raise ObjectPermissionsMissing, model
    end
  end

  private

  def function_can?(user, model, action)
    case action
    when :index, :show then true
    when :new, :create, :edit, :update, :destroy then user && user == model.user
    end
  end

  def comment_can?(user, model, action)
    case action
    when :index, :show then true
    when :new, :create, :edit, :update then user && user == model.user
    when :destroy then user && [model.user, model.function.user].include?(user)
    end
  end
end
