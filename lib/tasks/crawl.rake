# rake crawl:novel
# rake crawl:chapter

namespace :crawl do
  base_time = Time.now
  desc "sync novels from all source host"
  task :novel => :environment do
    SourceHost.all.each_with_index do |source_host, index|
      run_time = base_time + (index * 10)
      jid = CrawlNovelWorker.perform_at(run_time, source_host.id)
      puts "#{source_host.id}. #{source_host.name}: jid-#{jid}"
    end
  end

  desc "sync chapters from all novel"
  task :chapter => :environment do
    Novel.all.each_with_index do |novel, index|
      run_time = base_time + (index * 10)
      jid = CrawlChapterWorker.perform_at(run_time, novel.id)
      puts "#{novel.id}. #{novel.name}: jid-#{jid}"
    end
  end

end
