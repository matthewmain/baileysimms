# == Schema Information
#
# Table name: parts
#
#  id           :integer          not null, primary key
#  part_number  :integer
#  title        :string
#  content      :text
#  book_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  goodreads_id :string
#

require 'test_helper'

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
