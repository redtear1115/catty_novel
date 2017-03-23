desc "This task is called by the Heroku scheduler add-on"
task :sync_novels => :environment do
  Novel.all.each do |novel|
    jid = CrawlerWorker.perform_async(novel.id)
    puts jid
  end
end