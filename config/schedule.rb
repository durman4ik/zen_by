# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, '/path/to/my/cron_log.log'
#
every 1.day, at: '12:05 am' do
  rake 'delete:old_travel_groups'
  rake 'delete:blank_departures'
end

every 1.day, :at => '8:00 pm' do
  rake '-s sitemap:refresh'
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
