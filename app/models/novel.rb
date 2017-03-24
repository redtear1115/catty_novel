class Novel < ApplicationRecord
  after_create :init_chapter
  
  belongs_to :source_host
  has_many :collections
  has_many :chapters
  
  def chapter_index
    @chapter_index ||= []
    if @chapter_index.empty?
      temp_array = []
      external_ids = self.chapters.order(external_id: :asc).pluck(:external_id)
      external_ids.each do |external_id|
        splited_external_id = external_id.split('_')
        temp_array << splited_external_id[1].to_i
      end
      
      temp_array.sort.each {|a| @chapter_index << "postmessage_#{a.to_s}"}
    end
    return @chapter_index
  end
  
  def get_neighbors(external_id)
    array_idx = self.chapter_index.index(external_id)
    return { prev: 0, curr: 0, next: 1} if array_idx.nil?
    
    prev_idx = array_idx == 0 ? 0 : array_idx - 1
    next_idx = array_idx == (self.chapter_index.count - 1) ? array_idx : array_idx + 1
    return { prev: prev_idx, curr: array_idx, next: next_idx }
  end
  
  def init_chapter
    CrawlChapterWorker.perform_async(self.id)
  end
    
end
