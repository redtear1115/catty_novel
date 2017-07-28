class Novel < ApplicationRecord
  belongs_to :source_host
  has_many :collections, dependent: :destroy
  has_many :chapters, dependent: :destroy

  after_create :init_chapter

  default_scope { where(is_publish: true).order(updated_at: :desc) }
  scope :unpublish, -> { unscoped.where(is_publish: false) }
  scope :finished, -> { where(status: '已完結') }
  scope :in_progress, -> { where(status: '連載中') }

  def in_collection?(user)
    collection = user.collections.find_by(novel_id: self.id)
    return collection.present? ? true : false
  end

  def max_chapter_number
    CacheService.cache_integer("novel:#{self.id}:max") do
      self.chapters.maximum(:number)
    end
  end

  def min_chapter_number
    CacheService.cache_integer("novel:#{self.id}:min") do
      self.chapters.minimum(:number)
    end
  end

  def init_chapter
    CrawlChapterWorker.perform_async(self.id)
  end

  def self.create_with_params(params)
    sh = SourceHost.find_by(id: params[:source_host_id])
    return if sh.nil?
    return unless sh.valid_url?(params[:source_url])

    novel_attrs = CrawlNovelService.new.crawl_attrs(sh, params[:source_url])
    return if novel_attrs.nil?

    novel = Novel.new
    novel.assign_attributes(novel_attrs)
    novel.source_url = params[:source_url]
    novel.source_host = sh
    novel.save!
    novel
  end

end
