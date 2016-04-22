# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  date       :datetime
#  post_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_user_id_and_created_at  (user_id,created_at)
#

class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	has_many :replies, dependent: :destroy

	default_scope -> { order(created_at: :desc) } 		
					
	validates :user_id, presence: true												
	validates :content, presence: true, length: { maximum: 500 }

end
