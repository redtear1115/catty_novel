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
      # message: already existed
    else
      @novel = Novel.new
      @novel.create_by_url(current_user, source_url, source_host_id)
      if @novel
        # message: success
      else
        # message: can not read this url
      end
    end
    
    redirect_to root_path
  end
  
  def search
    search_term = "%#{permitted_params[:search_term]}%"
    @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term)
  end
  
  def search_result
    if permitted_params[:search_term]
      search_term = "%#{permitted_params[:search_term]}%"
      @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term).page(permitted_params[:page])
      
      # message: 查無相關書籍 
      redirect_to search_path if @novels.empty?
    else
      redirect_to novels_path
    end
  end
  
  private
  def permitted_params
    params.permit(:source_url, :source_host_id, :search_term)
  end
  
end
