class CrawlChapterWorker
  include Sidekiq::Worker
  
  def perform(novel_id)
    if novel = Novel.find_by(id: novel_id)
      CrawlChapterService.new.sync(novel)
    else
      Rails.logger.info("Novel id #{novel_id} not existed")
    end
  end
  
end