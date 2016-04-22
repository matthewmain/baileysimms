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

require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
