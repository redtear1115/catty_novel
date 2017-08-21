# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_collection!, only: [:read]
  before_action :verify_chapter!, only: [:read]

  def create
    novel = Novel.find_by(id: permitted_params[:novel_id])
    current_user.add_to_collection(novel) if novel
    flash[:notice] = '收藏建立成功'
    redirect_to root_path
  end

  def destroy
    collection = current_user.collections.find_by(id: permitted_params[:id])
    collection&.destroy
    flash[:notice] = '收藏刪除成功'
    redirect_to root_path
  end

  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end

  def read
    @neighbors = @chapter.neighbors
    @collection.update(last_read_chapter: @chapter.id)
  end

  def end_page; end

  private

  def permitted_params
    params.permit(:id, :novel_id, :chapter_number)
  end

  def verify_collection!
    redirect_to(end_page_path) && return if to_end_page?
    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    if @collection.nil?
      flash[:alert] = '尚未收藏，無法閱讀'
      redirect_to(root_path) && return
    else
      @novel = @collection.novel
    end
  end

  def verify_chapter!
    @chapter = find_chapter
    if @chapter.nil?
      flash[:alert] = '未知的章節，無法閱讀'
      redirect_to(root_path) && return
    end
  end

  def find_chapter
    return @novel.chapters.find_by(number: permitted_params[:chapter_number]) if permitted_params[:chapter_number].present?
    return @novel.chapters.find_by(id: @collection.last_read_chapter) if @collection.last_read_chapter.present?
    return @novel.chapters.first
  end

  def to_end_page?
    return false if permitted_params[:chapter_number].nil?
    permitted_params[:chapter_number] == 'end_page'
  end
end
