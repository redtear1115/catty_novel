class NovelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @novels = Novel.all.page(permitted_params[:page])
  end

  def new
    @source_hosts = SourceHost.all
    @novel = Novel.new
  end

  def create
    source_url = permitted_params[:source_url]
    source_host_id = permitted_params[:source_host_id]

    @novel = Novel.find_by(source_url: source_url, source_host_id: source_host_id)
    if @novel
      flash[:alert] = '書籍已存在'
    else
      @novel = Novel.create_by_url(source_url, source_host_id)
      if @novel.present?
        flash[:notice] = '書籍建立成功'
      else
        flash[:alert] = '書籍建立失敗'
      end
    end
    redirect_to novels_path
  end

  def search
    search_term = "%#{permitted_params[:search_term]}%"
    @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term)
  end

  def search_result
    if permitted_params[:search_term]
      search_term = "%#{permitted_params[:search_term]}%"
      @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term).page(permitted_params[:page])

      flash[:alert] = '查無相關書籍'
      redirect_to search_path if @novels.empty?
    else
      redirect_to novels_path
    end
  end

  private
  def permitted_params
    params.permit(:source_url, :source_host_id, :search_term, :page)
  end

end
