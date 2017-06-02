# == Schema Information
#
# Table name: comments
#
#  id                        :integer          not null, primary key
#  content                   :text
#  date                      :datetime
#  post_id                   :integer
#  user_id                   :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  display_on_community_page :boolean          default(TRUE)
#
# Indexes
#
#  index_comments_on_user_id_and_created_at  (user_id,created_at)
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
