class NovelsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @novels = Novel.where.not(last_sync_url: nil).order(updated_at: :desc)
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
  
  private
  def permitted_params
    params.permit(:source_url, :source_host_id)
  end
  
end
