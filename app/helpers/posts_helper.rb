# == Schema Information
#
# Table name: posts
#
#  id                :integer          not null, primary key
#  title             :string
#  date              :datetime
#  content           :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  visible_to_public :boolean          default(FALSE)
#  visible_to_users  :boolean          default(FALSE)
#  book_part         :integer
#  share_locked      :boolean          default(TRUE)
#

module PostsHelper

	def cover_image_of(post_title)
		if post_title.split('')[19] == ":"
			"DiB#{post_title.split('')[18]} cover thumb.jpg"
		else
			"DiB#{post_title.split('')[18]+post_title.split('')[19]} cover thumb.jpg"
		end
	end
	
end
