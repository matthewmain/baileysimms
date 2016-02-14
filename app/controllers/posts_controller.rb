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
    @post = Post.find(0)
    @post_id = 0         
    @intro_page = true
    @comment = current_user.comments.build if logged_in?
    @feed_items = @post.feed.paginate(page: params[:page]).per_page(5) 
  end

  def new
  end

  def create
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @post_id = @post.id
    if logged_in?                                   
      @comment = current_user.comments.build
      @feed_items = @post.feed.paginate(page: params[:page]).per_page(5)
    end                                              
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
