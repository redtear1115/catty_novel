class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end

  def read
    redirect_to end_page_path if go_to_end_page?

    @collection = current_user.collections.find_by(novel_id: home_parmas[:novel_id])
    @novel = @collection.novel
    @chapter = @novel.chapters.first

    if home_parmas[:chp_idx].nil?
      @chapter = @novel.chapters.find_by(id: @collection.last_read_chapter) if @collection.last_read_chapter.present?
    else
      external_id = @novel.chapter_index[home_parmas[:chp_idx].to_i]
      @chapter = @novel.chapters.find_by(external_id: external_id) if external_id.present?
    end

    setup_chp_idx(@novel.get_neighbors(@chapter.external_id))
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

  private

  def home_parmas
    params.permit(:novel_id, :chp_idx)
  end

  def disconnect_params
    params.permit(:identity_id)
  end

  def setup_chp_idx(chapter_indexes)
    return if go_to_end_page?
    return if chapter_indexes.nil?
    @chapter_indexes = chapter_indexes
    @collection.update(last_read_chapter: @chapter.id)
  end

  def go_to_end_page?
    return false if home_parmas[:chp_idx].nil?
    home_parmas[:chp_idx] == 'end_page'
  end

end
