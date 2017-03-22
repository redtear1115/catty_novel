class Novel < ApplicationRecord
  has_many :collections
  has_many :chapters
  
  def sync
    target_urls.each do |url|
      doc = Nokogiri::HTML(open(url))
      insert_chapter(doc)
    end
    self.update(last_sync_url: target_urls.last)
  end
  
  def insert_chapter(doc)
    postlist = doc.css('#postlist .plhin .t_f')
    postlist.each do |post|
      chapter = self.chapters.find_or_create_by(external_id: post['id'])
      chapter.update(content: post.content)
    end
    return self.chapters.count
  end
  
  def target_urls(full=false)
    return [] if source_page.nil?
    self.update(last_sync_url: self.source_url) if self.last_sync_url.nil?
    
    last_page_num = get_last_page_num(source_page)
    loop_times = full ? last_page_num : calc_loop_times(last_page_num)
    calc_urls(loop_times)
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
  
  private 
  def source_page
    return nil if self.source_url.nil?
    @source_page ||= Nokogiri::HTML(open(self.source_url))
  end
  
  def get_last_page_num(source_page)
    return source_page.css('.pgt .pg .last').first.content.gsub(/\D/,'').to_i
  end
  
  def calc_loop_times(last_page_num)
    splited_url = self.last_sync_url.split('-')
    return last_page_num - splited_url[2].to_i + 1
  end
  
  def calc_urls(loop_times)
    target_urls = []
    loop_times.times do |index|
      splited_url = self.last_sync_url.split('-')
      splited_url[2] = splited_url[2].to_i + index
      target_urls << splited_url.map(&:to_s).join('-')
    end
    return target_urls
  end
  
end
