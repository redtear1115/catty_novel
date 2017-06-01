class CrawlChapterWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  sidekiq_retry_in do |count|
    5.minutes * (count + 1)
  end

  def perform(novel_id)
    if novel = Novel.find_by(id: novel_id)
      CrawlChapterService.new.sync(novel)
    else
      Rails.logger.info("Novel id #{novel_id} not existed")
    end
  end

end
