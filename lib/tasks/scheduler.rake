# rake crawl:novel
# rake crawl:chapter

namespace :crawl do
  desc "This task is called by the Heroku scheduler add-on"
  task :novel => :environment do
    SourceHost.all.each do |source_host|
      jid = CrawlNovelWorker.perform_async(source_host.url)
      puts "#{source_host.id}. #{source_host.name}: jid-#{jid}"
    end
  end
  
  desc "This task is called by the Heroku scheduler add-on"
  task :chapter => :environment do
    Novel.all.each do |novel|
      jid = CrawlChapterWorker.perform_async(novel.id)
      puts "#{novel.id}. #{novel.name}: jid-#{jid}"
    end
  end
  
end