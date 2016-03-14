# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  user_name         :string
#  email             :string
#  password          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#  vip               :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

module UsersHelper

	def gravatar_for(user, options = { size: 150 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    image_tag(gravatar_url, alt: user.user_name, class: "gravatar")
	end

	def giveaway_winner(name)
		name == "AJ2002" || 
	 	name == "Chancelacy" ||
	 	name == "Tasneem" ||
	 	name == "samuelmax" ||
	 	name == "Tiff" ||
	 	name == "BbandHockey" ||

	 	name == "Mr_Blue" ||
	 	name == "Mr PPPPPPPPPPPPPPink" ? true : false;
	end		

	def total_words_commented(commenter)
		if User.find_by_user_name(commenter).comment_count > 0
			User.find_by_user_name(commenter).all_comments_word_count.to_s + " words"
		end
	end

	def total_words_commented_this_month(commenter)
		if User.find_by_user_name(commenter).comment_count_by_month(Time.now.month) > 0
			User.find_by_user_name(commenter).comments_word_count_by_month(Time.now.month).to_s + " words"
		end
	end

	def total_words_commented_last_month(commenter)
		if User.find_by_user_name(commenter).comment_count_by_month(1.month.ago.month) > 0
			User.find_by_user_name(commenter).comments_word_count_by_month(1.month.ago.month).to_s + " words"
		end
	end

end
