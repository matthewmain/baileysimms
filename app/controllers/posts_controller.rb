# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  date       :datetime
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostsController < ApplicationController

  def index
    @posts = Post.all
    @intro_page = true
    if logged_in?                                                     #HRTL 11.38, 11.45... <----*
      @comment = current_user.comments.build
      @feed_items = current_user.feed.paginate(page: params[:page]).per_page(5)
    end                                                               #... <----*
  end

  def new
  end

  def create
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    if logged_in?                                                     #HRTL 11.38, 11.45... <----*  (duplicated from index)
      @comment = current_user.comments.build
      @feed_items = current_user.feed.paginate(page: params[:page]).per_page(5)
    end                                                               #... <----*
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
