# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  date       :datetime
#  post_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]          #HRTL 11.32 <----*
  before_action :authorized_user, only: :destroy                    #HRTL 11.50 <----*

  def create                                                        
    @comment = current_user.comments.build(comment_params)          #HRTL 11.34... <----*
    if @comment.save
      flash[:success] = "Comment made!"
      redirect_to posts_path
    else
      @posts = Post.all
      @intro_page = true
      @feed_items = current_user.feed.paginate(page: params[:page]).per_page(5)
      render 'posts/index'
    end                                                             #... <----*
  end

  def destroy
    @comment.destroy                                                #HRTL 11.50... <----*
    flash[:success] = "Comment deleted"
    redirect_to request.referrer                                    #... <----*
  end

  private                                                           #HRTL 11.34... <----*

    def comment_params
      params.require(:comment).permit(:content)
    end                                                             #... <----*

    def comment_belongs_to_current_user?
      current_user.comments.find_by(id: params[:id])
    end

    def authorized_user    
      @comment = Comment.find(params[:id])                                                                 #HRTL 11.50... <----*
      redirect_to request.referrer unless comment_belongs_to_current_user? || current_user.admin?
    end                                                                                                     #... <----*
  
end

