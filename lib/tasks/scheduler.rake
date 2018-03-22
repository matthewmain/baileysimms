
desc "This task is called by the Heroku scheduler add-on"

task :update_rankings => :environment do
  puts "Updating rankings..."
  Ranking.update(1, data_hash: User.top_non_admin_users_by_share_plus_comment_counts(10))
  Ranking.update(2, data_hash: User.top_non_admin_users_by_share_plus_comment_counts_by_month(Time.now.month,Time.now.year,5))
  Ranking.update(3, data_hash: User.top_non_admin_users_by_share_plus_comment_counts_by_month(1.month.ago.month,1.month.ago.year,5))
  puts "done."
end