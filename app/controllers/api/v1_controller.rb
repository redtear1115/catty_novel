class Api::V1Controller < Api::ApplicationController
  before_action :verify_novel!, only: [:update_last_read_chapter]
  before_action :verify_chapter!, only: [:update_last_read_chapter]

  def update_last_read_chapter
    @collection.update(last_read_chapter: @chapter.id)
    render ok_page(@collection.simple)
  end

  def auth_info
    os = OmniauthService.new(omniauth_params[:provider], omniauth_params[:omniauth_token], omniauth_params[:omniauth_secret])
    auth_info = os.get_info
    if auth_info.nil?
      render forbidden_page('認證失敗')
    else
      render ok_page(auth_info)
    end
  end

  private

  def novel_params
    params.permit(:format, :novel_id, :chapter_number)
  end

  def omniauth_params
    params.permit(:format, :provider, :omniauth_token, :omniauth_secret)
  end

  def verify_novel!
    @collection = current_user.collections.find_by(novel_id: novel_params[:novel_id])
    message = "novel #{novel_params[:novel_id]} is not available"
    render forbidden_page(message) and return if @collection.nil?
  end

  def verify_chapter!
    if chapter_number_integer?
      @chapter = @collection.novel.chapters.find_by(number: novel_params[:chapter_number])
      message = "chapter #{novel_params[:chapter_number]} of novel #{novel_params[:novel_id]} is not available"
      render forbidden_page(message) and return if @chapter.nil?
    else
      render ok_page(@collection.simple)
    end
  end

  def chapter_number_integer?
    novel_params[:chapter_number].to_i.to_s == novel_params[:chapter_number]
  end

end
