# frozen_string_literal: true

class NovelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @novels = Novel.all.page(search_params[:page])
  end

  def new
    @source_hosts = SourceHost.all
    @novel = Novel.new
  end

  def create
    @novel = Novel.find_by(novel_params)
    if @novel.present?
      flash[:alert] = '書籍已存在'
    else
      @novel = Novel.create_with_params(novel_params)
      if @novel.present?
        flash[:notice] = '書籍建立成功'
      else
        flash[:alert] = '不合法的網址或標題，書籍建立失敗'
      end
    end
    redirect_to novels_path
  end

  def search; end

  def search_result
    redirect_to(novels_path) && return if search_params[:search_term].nil?

    search_term = "%#{search_params[:search_term]}%"
    @novels = Novel.where('name like ? OR author like ? OR catgory like ?', search_term, search_term, search_term).page(search_params[:page])
    if @novels.blank?
      flash[:alert] = '查無相關書籍'
      redirect_to search_path
    end
  end

  private

  def search_params
    params.permit(:search_term, :page)
  end

  def novel_params
    params.permit(:source_url, :source_host_id)
  end
end
