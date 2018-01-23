# frozen_string_literal: true

class Novel < ApplicationRecord
  belongs_to :source_host
  has_many :collections, dependent: :destroy
  has_many :chapters, dependent: :destroy

  default_scope { where(is_publish: true).order(updated_at: :desc) }
  scope :unpublish, -> { unscoped.where(is_publish: false) }
  scope :finished, -> { where(status: '已完結') }
  scope :in_progress, -> { where(status: '連載中') }

  def self.create_with_params(params)
    sh = SourceHost.find_by(id: params[:source_host_id])
    return if sh.nil?
    return unless sh.valid_url?(params[:source_url])

    novel_attrs = CrawlNovelService.new.crawl_attrs(params[:source_url])
    return if novel_attrs.nil?

    novel = Novel.new(source_url: params[:source_url], source_host: sh)
    novel.assign_attributes(novel_attrs)
    novel.save!
    CrawlChapterWorker.perform_async(novel.id)
    novel
  end

  def self.renew_unpublish
    self.unpublish.each do |novel|
      novel.sync_chapter
      novel.publish!
    end
  end

  def in_collection?(user)
    collection = user.collections.find_by(novel_id: id)
    collection.present? ? true : false
  end

  def max_chapter_number
    CacheService.cache_integer("novel:#{id}:max") do
      chapters.maximum(:number)
    end
  end

  def min_chapter_number
    CacheService.cache_integer("novel:#{id}:min") do
      chapters.minimum(:number)
    end
  end

  def sync_chapter
    CrawlChapterService.new.sync self
  end

  def publish!
    self.is_publish = true
    self.save!
  end
end
