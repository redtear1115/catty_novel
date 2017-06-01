set :output, './log/cron.log'

every 4.hours do
  rake 'crawl:chapter'
end

# every 4.hours do
#   rake 'crawl:novel'
# end
