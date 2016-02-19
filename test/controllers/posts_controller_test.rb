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
#

require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
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

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
