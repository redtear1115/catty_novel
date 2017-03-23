class CrawlerWorker
  include Sidekiq::Worker
  
  def perform(novel_id)
    novel = Novel.find_by(id: novel_id)
    crawler = Crawler.new.sync(novel) if novel
  end
  
end