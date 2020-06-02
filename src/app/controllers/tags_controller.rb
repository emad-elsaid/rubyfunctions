class TagsController < ApplicationController
  LIMIT = 30

  before_action :set_tag

  def show
    offset = params.fetch(:offset, 0).to_i

    @functions = @tag.functions.limit(LIMIT).offset(offset).order(likes_count: :desc).all
    @next = offset + LIMIT if @functions.size == LIMIT
  end

  def index; end

  private

  def set_tag
    @tag = Tag.from_param(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
