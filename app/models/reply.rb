# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  content    :text
#  comment_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reply < ActiveRecord::Base
	belongs_to :comment
	belongs_to :user

	default_scope -> { order(created_at: :desc) }

	validates :comment_id, presence: true
	validates :user_id, presence: true													
	validates :content, presence: true, length: { maximum: 500 }

end
