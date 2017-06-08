class CrawlNovelService

  def initialize
  end

  def sync(source_host)
    insert_novel(source_host)
    return source_host.novels.count
  end

  def crawl_attrs(source_host, source_url)
    html = Nokogiri::HTML(open(source_url))
    thread_subject = html.css('header #thread_subject').first
    if thread_subject
      raw_title = thread_subject.content
      return nil unless is_novel?(raw_title)
      return get_attr(raw_title)
    else
      return nil
    end
  end

  private
  def insert_novel(source_host)
    temp = []
    html = Nokogiri::HTML(open(source_host.url))
    postlist = html.css('.titleBox .blockTitle a')
    postlist.each do |post|
      next unless is_novel?(post['title'])
      source_url = post['href'].sub('http://', 'https://')
      novel = source_host.novels.find_or_create_by(source_url: source_url)
      novel.update(get_attr(post['title']))
    end
    return nil
  end

  def is_novel?(raw_title)
    return false if raw_title.nil?
    return /[\[,【](.*?)[\],】](.*?)作者[：,︰](.*?)[\(,（](.*?)[\),）]/ =~ raw_title ? true : false
  end

  def get_attr(raw_title)
    result = {}
    result[:catgory] = raw_title[/[\[,【](.*?)[\],】]/, 1]
    result[:name] = raw_title[/[\],】](.*?)作者[：,︰]/, 1]
    result[:author] = raw_title[/作者[：,︰](.*?)[\(,（]/, 1]
    result[:status] = raw_title[/[\(,（](.*?)[\),）]/, 1]
    result.each { |k,v| result[k] = v.strip unless v.nil? }
    return result
  end

end
