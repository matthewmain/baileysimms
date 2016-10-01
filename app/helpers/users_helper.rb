# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  user_name          :string
#  email              :string
#  password           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  password_digest    :string
#  remember_digest    :string
#  admin              :boolean          default(FALSE)
#  activation_digest  :string
#  activated          :boolean          default(FALSE)
#  activated_at       :datetime
#  reset_digest       :string
#  reset_sent_at      :datetime
#  vip                :boolean          default(FALSE)
#  share_count        :integer          default(0)
#  oauth_provider     :string
#  oauth_token        :string
#  oauth_expires_at   :datetime
#  facebook_id        :string
#  facebook_name      :string
#  facebook_image     :string
#  has_shared_website :boolean          default(FALSE)
#  can_access_AU_1    :boolean          default(FALSE)
#  can_access_part_2  :boolean          default(FALSE)
#  can_access_part_3  :boolean          default(FALSE)
#  can_access_part_4  :boolean          default(FALSE)
#  can_access_part_5  :boolean          default(FALSE)
#  can_access_part_6  :boolean          default(FALSE)
#  can_access_part_7  :boolean          default(FALSE)
#  can_access_part_8  :boolean          default(FALSE)
#  can_access_part_9  :boolean          default(FALSE)
#  can_access_part_10 :boolean          default(FALSE)
#  can_access_part_11 :boolean          default(FALSE)
#  can_access_part_12 :boolean          default(FALSE)
#  can_access_part_13 :boolean          default(FALSE)
#  can_access_part_14 :boolean          default(FALSE)
#  share_record       :text
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

module UsersHelper

	def user_image_for(user)
		if user.is_connected_to_facebook
			image_tag(user.facebook_image, alt: user.user_name, class: "user_image")
		else
	    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=150&d=identicon"
	    image_tag(gravatar_url, alt: user.user_name, class: "user_image")
		end
	end

	def giveaway_winner(name)
		name == "AJ2002" || 
	 	name == "Chancelacy" ||
	 	name == "Tasneem" ||
	 	name == "samuelmax" ||
	 	name == "Tiff" ||
	 	name == "BbandHockey" ||
	 	name == "PikachuBonnie" ||
	 	name == "Vissh" ||
	 	name == "zonika" ||
	 	name == "DanielleBBy" ||
	 	name == "Skittles4you" ||
	 	name == "CynthiaJade" ||
	 	name == "Jammymean" ||

	 	name == "Mr_Blue" ||
	 	name == "Mr_Pink" ? true : false;
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
