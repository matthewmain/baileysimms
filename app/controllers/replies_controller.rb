class RepliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]     
  before_action :authorized_user, only: :destroy        

  def create                                                  
    @reply = current_user.replies.build(reply_params)
    if @reply.save
      redirect_to request.referrer
    end              
  end

  def destroy
    @reply.destroy                       
    redirect_to request.referrer                       
  end

  private                                                        

    def reply_params
      params.require(:reply).permit(:content, :comment_id, :user_id)
    end                                                

    def reply_belongs_to_current_user?
      current_user.replies.find_by(id: params[:id])
    end

    def authorized_user    
      @reply = Reply.find(params[:id])                                                              
      redirect_to request.referrer unless reply_belongs_to_current_user? || current_user.admin?
    end  

end
