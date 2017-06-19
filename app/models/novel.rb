class Novel < ApplicationRecord
  belongs_to :source_host
  has_many :collections, dependent: :destroy
  has_many :chapters, dependent: :destroy

  after_create :init_chapter

  default_scope { where(is_publish: true).order(updated_at: :desc) }
  scope :unpublish, -> { unscope(:where).where(is_publish: false).order(updated_at: :desc) }

  def in_collection?(user)
    collection = user.collections.find_by(novel_id: self.id)
    return collection.present? ? true : false
  end

  def chapter_index
    redis_cache("novel:#{self.id}:index") do
      result = {}
      temp_array = []
      external_ids = self.chapters.order(external_id: :asc).pluck(:external_id)
      external_ids.each do |external_id|
        splited_external_id = external_id.split('_')
        temp_array << splited_external_id[1].to_i
      end
      temp_array.sort.each_with_index do |value, index|
        result[index.to_s] = "postmessage_#{value.to_s}"
      end
      result
    end
  end

  def max_chapter_index
    return 0 if chapter_index.empty?
    chapter_index.count - 1
  end

  def get_neighbors(external_id)
    array_idx = self.chapter_index.key(external_id)
    return { prev: 'end_page', curr: 0, next: 1} if array_idx.nil?
    array_idx = array_idx.to_i
    prev_idx = array_idx <= 0 ? 'end_page' : array_idx - 1
    next_idx = array_idx >= (self.chapter_index.count - 1) ? 'end_page' : array_idx + 1
    return { prev: prev_idx, curr: array_idx, next: next_idx }
  end

  def init_chapter
    CrawlChapterWorker.perform_async(self.id)
  end

  def self.create_by_url(source_url, source_host_id)
    sh = SourceHost.find_by(id: source_host_id)
    return nil if sh.nil?

    if sh.valid_url?(source_url)
      cns = CrawlNovelService.new
      if novel_attrs = cns.crawl_attrs(sh, source_url)
        novel = Novel.new
        novel.assign_attributes(novel_attrs)
        novel.source_url = source_url
        novel.source_host = sh
        novel.save!
      else
        return nil
      end
    else
      return nil
    end

    return novel
  end

  def self.delete_dupicated_url
    grouped = self.all.group_by{ |novel| novel.source_url }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each{ |dup_record| dup_record.destroy }
    end
  end

  private

  def redis_cache(key, expires_time=1.day)
    return $redis.hgetall(key) if $redis.hgetall(key).any?

    chapter_index = yield
    chapter_index.each do |index, external_id|
      $redis.hset(key, index, external_id)
      $redis.expire(key, expires_time)
    end
    chapter_index
  end

end
