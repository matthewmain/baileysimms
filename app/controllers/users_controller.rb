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

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
    @top_ten_contributors_all_time = Ranking.find_by_name("top_ten_all_time").data_hash
    @top_five_contributors_this_month = Ranking.find_by_name("top_five_this_month").data_hash
    @top_five_contributors_last_month = Ranking.find_by_name("top_five_last_month").data_hash
    @recent_comments = Comment.limit(50)
  end

  def new
    @user = User.new
  end

  def create
    user_params[:user_name].gsub!(/\s/, '_')
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:activate] =  "Thanks for signing up! Check your email to activate your account.<br> 
                          <div style='font-size:11px;margin-top:3px'>(Might take a couple minutes, so just hang tight if you don't see an email right away.)</div>"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_user_name(params[:id])
    @comments = @user.comments           
  end

  def edit
    @user = User.find_by_user_name(params[:id])
  end

  def update
    @user = User.find_by_user_name(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your settings have been successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by_user_name(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  def log_shares
    current_user.update_attribute(:share_count, current_user.share_count+1 ) if params[:share_status] == "shared"
  end



  private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end


    ### BEFORE-FILTERS ###

    #confirms that a user is authorized
    def correct_user
      @user = User.find_by_user_name(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    #confirms a vip user (has read-only access to all posts)
    def vip_user
      redirect_to(root_url) unless current_user.vip?
    end
  
end
