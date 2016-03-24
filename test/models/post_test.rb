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
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
