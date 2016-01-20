# == Schema Information
#
# Table name: parts
#
#  id          :integer          not null, primary key
#  part_number :integer
#  title       :string
#  book_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Part < ActiveRecord::Base
	belongs_to :book
end
