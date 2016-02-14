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



class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	default_scope -> { order(created_at: :desc) } 						
	validates :user_id, presence: true												
	validates :content, presence: true, length: { maximum: 500 }

end
