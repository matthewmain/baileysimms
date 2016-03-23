# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  user_name          :string
#  email              :string
#  password           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  password_digest    :string
#  remember_digest    :string
#  admin              :boolean          default(FALSE)
#  activation_digest  :string
#  activated          :boolean          default(FALSE)
#  activated_at       :datetime
#  reset_digest       :string
#  reset_sent_at      :datetime
#  vip                :boolean          default(FALSE)
#  share_count        :integer          default(1)
#  oauth_provider     :string
#  oauth_token        :string
#  oauth_expires_at   :datetime
#  facebook_id        :string
#  facebook_name      :string
#  facebook_image     :string
#  has_shared_website :boolean          default(FALSE)
#  has_shared_part_1  :boolean          default(FALSE)
#  has_shared_part_2  :boolean          default(FALSE)
#  has_shared_part_3  :boolean          default(FALSE)
#  has_shared_part_4  :boolean          default(FALSE)
#  has_shared_part_5  :boolean          default(FALSE)
#  has_shared_part_6  :boolean          default(FALSE)
#  has_shared_part_7  :boolean          default(FALSE)
#  has_shared_part_8  :boolean          default(FALSE)
#  has_shared_part_9  :boolean          default(FALSE)
#  has_shared_part_10 :boolean          default(FALSE)
#  has_shared_part_11 :boolean          default(FALSE)
#  has_shared_part_12 :boolean          default(FALSE)
#  has_shared_part_13 :boolean          default(FALSE)
#  has_shared_part_14 :boolean          default(FALSE)
#  has_shared_book_1  :boolean          default(FALSE)
#  has_shared_book_2  :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

end
