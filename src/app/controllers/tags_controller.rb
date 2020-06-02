class TagsController < ApplicationController
  LIMIT = 30

  before_action :set_tag, only: [:show]

  def show
    offset = params.fetch(:offset, 0).to_i
    @functions = @tag.functions.limit(LIMIT).offset(offset).order(created_at: :desc).all
    @next = offset + LIMIT if @functions.size == LIMIT
  end

  def index
    offset = params.fetch(:offset, 0).to_i
    @tags = Tag.limit(LIMIT).offset(offset).order(functions_tags_count: :desc).all
    @next = offset + LIMIT if @tags.size == LIMIT
  end

  private

  def set_tag
    @tag = Tag.from_param(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
