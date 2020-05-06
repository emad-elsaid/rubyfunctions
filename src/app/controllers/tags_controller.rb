class TagsController < ApplicationController
  LIMIT = 30

  def show
    offset = params.fetch(:offset, 0).to_i

    @tag = params[:id]
    @functions = Tag.from_param(@tag).functions.limit(LIMIT).offset(offset).order(likes_count: :desc).all ||
                 raise(ActiveRecord::RecordNotFound)

    @next = offset + LIMIT if @functions.size == LIMIT
  end

  def index; end
end
