# == Schema Information
#
# Table name: crons
#
#  id         :integer          not null, primary key
#  name       :string
#  data_hash  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CronTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
