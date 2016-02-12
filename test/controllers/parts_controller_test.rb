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

class PartsControllerTest < ActionController::TestCase
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
