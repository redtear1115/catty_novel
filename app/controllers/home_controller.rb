class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @collections = current_user.collections.order(updated_at: :desc)
  end
  
  def read
    @collection = current_user.collections.find_by(novel_id: permitted_params[:novel_id])
    @novel = @collection.novel
    
    if permitted_params[:chp_idx].nil?
      if @collection.last_read_chapter.nil?
        @chapter = @novel.chapters.first
      else
        @chapter = @novel.chapters.find(@collection.last_read_chapter)
      end
    else
      external_id = @novel.chapter_index[permitted_params[:chp_idx].to_i]
      if external_id.nil?
        @chapter = @novel.chapters.first
      else
        @chapter = @novel.chapters.find_by(external_id: external_id)
      end
    end
    hash = @novel.get_neighbors(@chapter.external_id)
    @prev_chp_idx = hash[:prev]
    @curr_chp_idx = hash[:curr]
    @next_chp_idx = hash[:next]
    @collection.update(last_read_chapter: @chapter.id)
  end
  
  def add_to_collection
    novel = Novel.find_by(id: permitted_params[:novel_id])
    current_user.add_to_collection(novel) if novel
    redirect_to root_path
  end
  
  def remove_collection
    collection = current_user.collections.find_by(id: permitted_params[:collection_id])
    collection.destroy if collection
    redirect_to root_path
  end
  
  def search
    search_term = "%#{permitted_params[:search_term]}%"
    @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term)
  end
  
  private
  def permitted_params
    params.permit(:novel_id, :chp_idx, :collection_id)
  end
end
