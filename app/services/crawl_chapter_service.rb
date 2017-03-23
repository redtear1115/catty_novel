class CrawlChapterService
  
  def initialize
  end
  
  def sync(novel, full=false)
    novel.update(last_sync_url: novel.source_url) if novel.last_sync_url.nil?
    target_urls(novel, full).each { |url| insert_chapter(novel, url) }
    return novel.chapters.count
  end
  
  def target_urls(novel, full=false)
    return [] if novel.source_url.nil?
    source_page = Nokogiri::HTML(open(novel.source_url))
    return [] if source_page.nil?
    last_page_num = source_page.css('.pgt .pg .last').first.content.gsub(/\D/,'').to_i
    loop_times = full ? last_page_num : calc_loop_times(last_page_num, novel.last_sync_url)
    calc_urls(loop_times, novel.last_sync_url)
  end
  
  private
  def insert_chapter(novel, url)
    doc = Nokogiri::HTML(open(url))
    postlist = doc.css('#postlist .plhin .t_f')
    postlist.each do |post|
      chapter = novel.chapters.find_or_create_by(external_id: post['id'])
      chapter.update(content: post.content)
    end
    return  novel.update(last_sync_url: url)
  end
  
  def calc_loop_times(last_page_num, last_sync_url)
    splited_url = last_sync_url.split('-')
    return last_page_num - splited_url[2].to_i + 1
  end
  
  def calc_urls(loop_times, last_sync_url)
    target_urls = []
    loop_times.times do |index|
      splited_url = last_sync_url.split('-')
      splited_url[2] = splited_url[2].to_i + index
      target_urls << splited_url.map(&:to_s).join('-')
    end
    return target_urls
  end
  
end