class Api::V1Controller < Api::ApplicationController
  before_action :verify_novel!
  before_action :verify_chapter!

  def update_last_read_chapter
    @collection.update(last_read_chapter: @chapter.id)
    render ok_page(@collection.simple)
  end

  private

  def permitted_params
    params.permit(:format, :novel_id, :chapter_number)
  end

  def verify_novel!
    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    message = "novel #{permitted_params[:novel_id]} is not available"
    render forbidden_page(message) and return if @collection.nil?
  end

  def verify_chapter!
    if chapter_number_integer?
      @chapter = @collection.novel.chapters.find_by(number: permitted_params[:chapter_number])
      message = "chapter #{permitted_params[:chapter_number]} of novel #{permitted_params[:novel_id]} is not available"
      render forbidden_page(message) and return if @chapter.nil?
    else
      render ok_page(@collection.simple)
    end
  end

  def chapter_number_integer?
    permitted_params[:chapter_number].to_i.to_s == permitted_params[:chapter_number]
  end

end
