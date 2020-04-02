module PermissionsConcern
  extend ActiveSupport::Concern

  class ObjectPermissionsMissing < StandardError; end

  included do
    helper_method :can?
  end

  def can?(model, action)
    case model
    when Function then function_can?(model, action)
    when Comment then comment_can?(model, action)
    when Like then like_can?(model, action)
    when Save then save_can?(model, action)
    else raise ObjectPermissionsMissing, model
    end
  end

  private

  def function_can?(model, action)
    case action
    when :index, :show then true
    when :new, :create, :edit, :update, :destroy then current_user && current_user == model.user
    end
  end

  def comment_can?(model, action)
    case action
    when :index, :show then true
    when :new, :create, :edit, :update then current_user && current_user == model.user
    when :destroy then current_user && [model.user, model.function.user].include?(current_user)
    end
  end

  def like_can?(model, action)
    case action
    when :create, :destroy then current_user && current_user == model.user
    end
  end

  def save_can?(model, action)
    case action
    when :create, :destroy then current_user && current_user == model.user
    end
  end
end
