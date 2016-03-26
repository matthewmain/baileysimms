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
#  share_count        :integer          default(0)
#  oauth_provider     :string
#  oauth_token        :string
#  oauth_expires_at   :datetime
#  facebook_id        :string
#  facebook_name      :string
#  facebook_image     :string
#  has_shared_website :boolean          default(FALSE)
#  can_access_AU_1    :boolean          default(FALSE)
#  can_access_part_2  :boolean          default(FALSE)
#  can_access_part_3  :boolean          default(FALSE)
#  can_access_part_4  :boolean          default(FALSE)
#  can_access_part_5  :boolean          default(FALSE)
#  can_access_part_6  :boolean          default(FALSE)
#  can_access_part_7  :boolean          default(FALSE)
#  can_access_part_8  :boolean          default(FALSE)
#  can_access_part_9  :boolean          default(FALSE)
#  can_access_part_10 :boolean          default(FALSE)
#  can_access_part_11 :boolean          default(FALSE)
#  can_access_part_12 :boolean          default(FALSE)
#  can_access_part_13 :boolean          default(FALSE)
#  can_access_part_14 :boolean          default(FALSE)
#  share_record       :text
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
    #update's user's share count
    current_user.update_attribute(:share_count, current_user.share_count+1 )
    #if website is shared, logs it so only shared on user's first share
    current_user.update_attribute(:has_shared_website, true) if params[:shared] == "website"
    #unlocks any segment that AJAX call tells it to
    current_user.update_attribute("can_access_#{params[:unlocked_segment]}", true)
    #when any part is shared, always unlocks following part
    current_user.update_attribute("can_access_part_#{(params[:unlocked_segment][-1].to_i)+1}", true) if params[:unlocked_segment].slice(0,4) == "Part"
    #logs share into user's share record
    current_user.update_attribute(:share_record, (current_user.share_record << "#{params[:shared].upcase} (#{Time.now})") )
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
