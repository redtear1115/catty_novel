class Novel < ApplicationRecord
  belongs_to :source_host
  has_many :collections
  has_many :chapters

  after_create :init_chapter

  default_scope { where(is_publish: true).order(updated_at: :desc) }

  def available?
    last_sync_url.nil? ? false : true
  end

  def chapter_index
    @chapter_index ||= []
    if @chapter_index.empty?
      temp_array = []
      external_ids = self.chapters.order(external_id: :asc).pluck(:external_id)
      external_ids.each do |external_id|
        splited_external_id = external_id.split('_')
        temp_array << splited_external_id[1].to_i
      end

      temp_array.sort.each{ |a| @chapter_index << "postmessage_#{a.to_s}" }
    end
    return @chapter_index
  end

  def get_neighbors(external_id)
    array_idx = self.chapter_index.index(external_id)
    return { prev: 'end_page', curr: 0, next: 1} if array_idx.nil?

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

end
