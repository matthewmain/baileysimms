# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  user_name         :string
#  email             :string
#  password          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user_params[:user_name].gsub!(/\s/, '_')
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = "Thanks for signing up! Check your email to activate your account."
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
  
end
