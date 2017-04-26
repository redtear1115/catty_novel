class CrawlNovelWorker
  include Sidekiq::Worker
  
  def perform(source_host_id)
    if source_host = SourceHost.find_by(id: source_host_id)
      CrawlNovelService.new.sync(source_host)
    else
      Rails.logger.info("Source Host id #{source_host_id} not existed")
    end
  end
  
end