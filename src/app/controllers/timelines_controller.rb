class TimelinesController < ApplicationController
  LIMIT = 30

  def latest
    @functions = Function.limit(LIMIT).order(created_at: :desc).all
  end

  def liked
    @functions = Function.limit(LIMIT).order(likes_count: :desc).all
    render :latest
  end

  def commented
    @functions = Function.limit(LIMIT).order(comments_count: :desc).all
    render :latest
  end

  def saved
    @functions = Function.limit(LIMIT).order(saves_count: :desc).all
    render :latest
  end

  def contributors
    @users = User.limit(LIMIT).order(functions_count: :desc).all
  end
end
