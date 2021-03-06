# == Schema Information
#
# Table name: comments
#
#  id                        :integer          not null, primary key
#  content                   :text
#  date                      :datetime
#  post_id                   :integer
#  user_id                   :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  display_on_community_page :boolean          default(TRUE)
#
# Indexes
#
#  index_comments_on_user_id_and_created_at  (user_id,created_at)
#

class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]     
  before_action :authorized_user, only: :destroy        

  def create                                                  
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to request.referrer + "#comments"
    else
      redirect_to request.referrer + "#comments"
    end              
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(comment_params)
    redirect_to request.referrer
  end

  def destroy
    @comment.destroy                       
    flash[:success] = "Comment deleted"
    redirect_to request.referrer + "#comments"                  
  end

  private                                                        

    def comment_params
      params.require(:comment).permit(:content, :post_id, :date, :display_on_community_page)
    end                                                

    def comment_belongs_to_current_user?
      current_user.comments.find_by(id: params[:id])
    end

    def authorized_user    
      @comment = Comment.find(params[:id])                                                              
      redirect_to request.referrer unless comment_belongs_to_current_user? || current_user.admin?
    end                                                                                        
  
end

