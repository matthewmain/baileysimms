# == Schema Information
#
# Table name: parts
#
#  id          :integer          not null, primary key
#  book_id     :integer
#  part_number :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
