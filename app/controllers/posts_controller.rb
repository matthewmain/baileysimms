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
#  share_locked      :boolean          default(TRUE)
#

class PostsController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @post = Post.find(1)
    @post_id = @post.id         
    @intro_page = true
    @comment = current_user.comments.build if logged_in?
    @feed_items = @post.feed.paginate(page: params[:page]).per_page(250)
    @reply = current_user.replies.build if logged_in?
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "\"#{@post.title}\" was successfully posted."
      redirect_to new_post_path
    else
      render 'new'
    end
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @post_id = @post.id                                  
    @comment = current_user.comments.build if logged_in?
    @feed_items = @post.feed.paginate(page: params[:page]).per_page(250)
    @reply = current_user.replies.build if logged_in?
    store_location
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "\"#{@post.title}\" was successfully updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    title = Post.find(params[:id]).title
    Post.find(params[:id]).destroy
    flash[:success] = "\"#{title}\" was successfully deleted"
    redirect_to posts_url
  end
  
end


  private

    def post_params
      params.require(:post).permit(:title, :date, :content, :visible_to_public, :visible_to_users)
    end

    #confirms an admin user
    def admin_user
      redirect_to(root_url) unless logged_in? && current_user.admin?
    end
