class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def create
    novel = Novel.find_by(id: permitted_params[:novel_id])
    current_user.add_to_collection(novel) if novel
    flash[:notice] = '收藏建立成功'
    redirect_to root_path
  end

  def destroy
    collection = current_user.collections.find_by(id: permitted_params[:id])
    collection.destroy if collection
    flash[:notice] = '收藏刪除成功'
    redirect_to root_path
  end

  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end

  def read
    redirect_to end_page_path if to_end_page?
    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    @novel = @collection.novel
    @chapter = find_chapter
    @neighbors = @novel.get_neighbors(@chapter.number)
  end

  def end_page
  end

  private

  def permitted_params
    params.permit(:id, :novel_id, :chapter_number)
  end

  def find_chapter
    chapter = if permitted_params[:chapter_number].present?
      @novel.chapters.find_by(number: permitted_params[:chapter_number])
    elsif @collection.last_read_chapter.present?
      @novel.chapters.find_by(id: @collection.last_read_chapter)
    end
    return chapter if chapter.present?
    @novel.chapters.first
  end

  def to_end_page?
    return false if permitted_params[:chapter_number].nil?
    permitted_params[:chapter_number] == 'end_page'
  end

end
