class Api::V1Controller < Api::ApplicationController

  def setup_chp_idx
    collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    if collection.nil?
      render fail_page 'novel not found'
    else
      chapter_external_id = collection.novel.chapter_index[permitted_params[:chp_idx].to_i]
      if chapter_external_id.nil?
        render fail_page 'chapter index not found'
      else
        chapter = collection.novel.chapters.find_by(external_id: chapter_external_id)
        if chapter.nil?
          render fail_page 'chapter not found'
        else
          collection.update(last_read_chapter: chapter.id)
          render success_page(collection.reload)
        end
      end
    end
  end

  private

  def permitted_params
    params.permit(:novel_id, :chp_idx)
  end

end
