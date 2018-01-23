# frozen_string_literal: true

class CrawlNovelService
  def initialize
    @novel_regexp = /[\[,【](.*?)[\],】](.*?)作者[：,:,︰](.*?)[\(,（](.*?)[\),）]/
  end

  def sync(source_host)
    insert_novel(source_host)
  end

  def crawl_attrs(_source_host, source_url)
    html = read_to_html(source_url)
    thread_subject = html.at_css('header #thread_subject')
    return if thread_subject.nil?
    return cast_to_attrs(thread_subject.content)
  end

  private

  def insert_novel(source_host)
    new_novels = []
    html = read_to_html(source_host.url)
    postlist = html.css('.titleBox .blockTitle a')
    postlist.each do |post|
      attrs = cast_to_attrs(post['title'])
      next if attrs.nil?
      source_url = post['href'].sub('http://', 'https://')
      novel = source_host.novels.find_or_create_by(source_url: source_url)
      novel.update(attrs)
      new_novels << novel
    end
    new_novels
  end

  def cast_to_attrs(raw_title)
    return nil if raw_title.nil?
    match_data = @novel_regexp.match(raw_title)
    return nil if match_data.nil?
    {
      catgory: match_data[1].strip,
      name: match_data[2].strip,
      author: match_data[3].strip,
      status: match_data[4].strip
    }
  end

  def read_to_html(url)
    response_body = Net::HTTP.get(URI.parse(url))
    Nokogiri::HTML(response_body.force_encoding('utf-8'))
  rescue => e
    Rails.logger.error("Open url fail: #{e}")
  end
end
