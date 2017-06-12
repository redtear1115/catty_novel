class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end

  def read
    redirect_to end_page_path if go_to_end_page?

    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    @novel = @collection.novel
    @chapter = @novel.chapters.first

    if permitted_params[:chp_idx].nil?
      @chapter = @novel.chapters.find_by(id: @collection.last_read_chapter) if @collection.last_read_chapter.present?
    else
      external_id = @novel.chapter_index[permitted_params[:chp_idx].to_i]
      @chapter = @novel.chapters.find_by(external_id: external_id) if external_id.present?
    end

    setup_chp_idx(@novel.get_neighbors(@chapter.external_id))
  end

  def end_page
  end

  private

  def permitted_params
    params.permit(:novel_id, :chp_idx)
  end

  def setup_chp_idx(chapter_indexes)
    return if go_to_end_page?
    return if chapter_indexes.nil?
    @chapter_indexes = chapter_indexes
  end

  def go_to_end_page?
    return false if permitted_params[:chp_idx].nil?
    permitted_params[:chp_idx] == 'end_page'
  end

end
