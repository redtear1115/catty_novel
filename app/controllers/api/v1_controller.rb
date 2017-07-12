class Api::V1Controller < Api::ApplicationController
  before_action :check_novel, :check_chp_idx, :check_chapter

  def setup_chp_idx
    if params[:chp_idx].to_i.to_s == params[:chp_idx]
      @collection.update(last_read_chapter: @chapter.id)
      @page_to_render = success_page(@collection.simple)
    else
      @page_to_render = success_page(params[:chp_idx])
    end

    render @page_to_render
  end

  private

  def permitted_params
    params.permit(:format, :novel_id, :chp_idx)
  end

  def check_novel
    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    render not_found_page('novel not found') and return if @collection.nil?
  end

  def check_chp_idx
    @chapter_external_id = @collection.novel.chapter_index[permitted_params[:chp_idx]]
    render not_found_page('chapter index not found') and return if @chapter_external_id.nil?
  end

  def check_chapter
    @chapter = @collection.novel.chapters.find_by(external_id: @chapter_external_id)
    render not_found_page('chapter not found') and return if @chapter.nil?
  end

end
