class CrawlNovelWorker
  include Sidekiq::Worker
  
  def perform(source_host_id)
    source_host = SourceHost.find_by(id: source_host_id)
    CrawlNovelService.new.sync(source_host) if source_host
  end
  
end