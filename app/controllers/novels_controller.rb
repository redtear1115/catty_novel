class NovelsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @novels = Novel.where.not(last_sync_url: nil).order(updated_at: :desc)
  end
  
  def new
    @novel = Novel.new
  end
  
  def create
    @novel = Novel.find_by(permitted_params)
    if @novel
      # message: already existed
    else
      @novel.create(permitted_params)
    end
    
    redirect_to root_path
  end
  
  private
  def permitted_params
    params.require(:novel).permit(:source_url, :source_host_id)
  end
  
end
