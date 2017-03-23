class CrawlNovelWorker
  include Sidekiq::Worker
  
  def perform(url)
    crawler = CrawlNovelService.new.sync(url)
  end
  
end