# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  user_name         :string
#  email             :string
#  password          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#  vip               :boolean          default(FALSE)
#  part_access_level :integer          default(1)
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
