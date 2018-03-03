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

class Post < ActiveRecord::Base
	has_many :comments

	default_scope -> { order(date: :asc) }

	validates :book_part, presence: true
	validates :title, presence: true
	validates :date, presence: true, timeliness: {type: :datetime}
	validates :content, presence: true


	def feed																													
		Comment.where("post_id = ?", id)
	end		
	
end
