class CrawlChapterService

  def initialize
  end

  def sync(novel, full=false)
    novel.update(last_sync_url: novel.source_url) if novel.last_sync_url.nil?
    target_urls(novel, full).each { |url| insert_chapter(novel, url) }
    return novel.chapters.count
  end

  def target_urls(novel, full=false)
    begin
      return [] if novel.source_url.nil?
      html = Nokogiri::HTML(open(novel.source_url))
      last_page_ele = html.css('.pgt .pg a')[-2]
      last_page_num = last_page_ele.content.gsub(/\D/,'').to_i
      loop_times = full ? last_page_num : calc_loop_times(last_page_num, novel.last_sync_url)
      return calc_urls(loop_times, novel.last_sync_url)
    rescue => e
      Rails.logger.info("Nokogiri parse fail: #{e}")
    end
  end

  private
  def insert_chapter(novel, url)
    begin
      html = Nokogiri::HTML(open(url))
      postlist = html.css('#postlist .plhin .t_f')
      postlist.each do |post|
        chapter = novel.chapters.find_or_create_by(external_id: post['id'])
        chapter.update(content: post.content)
      end
      return  novel.update(last_sync_url: url)
    rescue => e
      novel.update(is_publish: false)
      Rails.logger.info("Nokogiri parse fail: #{e}")
    end
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
