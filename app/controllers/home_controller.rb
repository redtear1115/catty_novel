class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end

  def read
    redirect_to end_page_path if to_end_page?
    @collection = current_user.collections.find_by(novel_id: home_parmas[:novel_id])
    @novel = @collection.novel
    @chapter = find_chapter
    @neighbors = @novel.get_neighbors(@chapter.number)
  end

  def end_page
  end

  def account
    @identity = {}
    current_user.identities.each do |identity|
      @identity[identity.provider] = identity.id
    end
    @identity
  end

  def disconnect
    Identity.delete(disconnect_params[:identity_id])
    flash[:notice] = '已中斷連結'
    redirect_to account_path
  end

  def auth_info
    os = OmniauthService.new(omniauth_params[:provider], omniauth_params[:access_token], omniauth_params[:secret])
    data = os.get_info
    head 400 and return if data.nil?
    render json: { code: 200, message: :ok, data: data }
  end

  private

  def home_parmas
    params.permit(:novel_id, :chapter_number)
  end

  def disconnect_params
    params.permit(:identity_id)
  end

  def omniauth_params
    params.permit(:provider, :access_token, :secret)
  end

  def find_chapter
    chapter = if home_parmas[:chapter_number].present?
      @novel.chapters.find_by(number: home_parmas[:chapter_number])
    elsif @collection.last_read_chapter.present?
      @novel.chapters.find_by(id: @collection.last_read_chapter)
    end
    return chapter if chapter.present?
    @novel.chapters.first
  end

  def to_end_page?
    return false if home_parmas[:chapter_number].nil?
    home_parmas[:chapter_number] == 'end_page'
  end

end
