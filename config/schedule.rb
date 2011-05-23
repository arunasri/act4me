every 7.days do
  rake "tweets:month_releases"
end

every 1.day, :at => '4:30 am' do
  rake "tweets:last_week_releases"
end

every :hour do
  rake "tweets:this_week_releases"
end

#every 20.hours do
#rake "handy:db:dump2s3"
#end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
