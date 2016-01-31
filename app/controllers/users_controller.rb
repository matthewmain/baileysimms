class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Alright. Cool. You're a member of Bailey's website."
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your settings have been successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end


  private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end


    ### BEFORE FILTERS ###

    #confirms that a user is logged in
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "You'd better log in if you're going to try to do that sort of thing."
        redirect_to login_url
      end
    end

    #confirms that a user is authorized
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
end
