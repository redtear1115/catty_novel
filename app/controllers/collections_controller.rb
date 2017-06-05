class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def create
    novel = Novel.find_by(id: permitted_params[:novel_id])
    current_user.add_to_collection(novel) if novel
    flash[:notice] = '收藏建立成功'
    redirect_to root_path
  end

  def destroy
    collection = current_user.collections.find_by(id: permitted_params[:id])
    collection.destroy if collection
    flash[:notice] = '收藏刪除成功'
    redirect_to root_path
  end

  private

  def permitted_params
    params.permit(:novel_id, :id)
  end

end
