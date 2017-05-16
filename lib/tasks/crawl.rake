# rake crawl:novel
# rake crawl:chapter

namespace :crawl do
  desc "sync novels from all source host"
  task :novel => :environment do
    SourceHost.all.each do |source_host|
      jid = CrawlNovelWorker.perform_async(source_host.id)
      puts "#{source_host.id}. #{source_host.name}: jid-#{jid}"
    end
  end

  desc "sync chapters from all novel"
  task :chapter => :environment do
    Novel.all.each do |novel|
      jid = CrawlChapterWorker.perform_async(novel.id)
      puts "#{novel.id}. #{novel.name}: jid-#{jid}"
    end
  end

end
