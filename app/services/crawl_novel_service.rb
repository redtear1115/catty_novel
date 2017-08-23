# frozen_string_literal: true

class CrawlNovelService
  def initialize; end

  def sync(source_host)
    insert_novel(source_host)
    source_host.novels.count
  end

  def crawl_attrs(_source_host, source_url)
    html = Nokogiri::HTML(open(source_url))
    thread_subject = html.css('header #thread_subject').first
    return if thread_subject.nil?
    return cast_to_attrs(thread_subject.content)
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
    nil
  end

  def cast_to_attrs(raw_title)
    return nil if raw_title.nil?
    if /[\[,【](.*?)[\],】](.*?)作者[：,:,︰](.*?)[\(,（](.*?)[\),）]/ =~ raw_title
      result = {}
      result[:catgory] = raw_title[/[\[,【](.*?)[\],】]/, 1]
      result[:name] = raw_title[/[\],】](.*?)作者[：,:,︰]/, 1]
      result[:author] = raw_title[/作者[：,︰](.*?)[\(,（]/, 1]
      result[:status] = raw_title[/[\(,（](.*?)[\),）]/, 1]
      result.each { |k, v| result[k] = v.strip unless v.nil? }
      return result
    else
      return nil
    end
  end
end
