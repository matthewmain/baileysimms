# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  date       :datetime
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
	has_many :comments

	default_scope -> { order(date: :desc) }

	validates :title, presence: true
	validates :date, presence: true, timeliness: {type: :datetime}
	validates :content, presence: true


	def feed																													
		Comment.where("post_id = ?", id)
	end		
	
end
