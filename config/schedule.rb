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





# Must update crontab with: $ whenever --update-crontab
# To check crontab, use: $ crontab -l

# (For scheduled tasks in production (Heroku), see 'lib/tasks/scheduler.rake' and 'https://scheduler.heroku.com/dashboard')

every '0 0 * * *' do
	#updates 'top_ten_all_time' ranking (id: 1)
	runner "Ranking.update(1, data_hash: User.top_non_admin_users_by_unique_share_plus_comment_counts(10))", :environment => "development"
	#updates 'top_five_this_month' ranking (id: 2)
	runner "Ranking.update(2, data_hash: User.top_non_admin_users_by_unique_share_plus_comment_counts_by_month(Time.now.month,Time.now.year,5))", :environment => "development"
	#updates 'top_five_last_month' ranking (id: 3) (Note: conditional in argument avoids whenever gem bug that automatically converts '1.month' to seconds)
	runner "Ranking.update(3, data_hash: User.top_non_admin_users_by_unique_share_plus_comment_counts_by_month(1.month.ago.month,1.month.ago.year,5))", :environment => "development"
end



