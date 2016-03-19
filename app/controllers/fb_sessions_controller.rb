class FbSessionsController < ApplicationController

  def create
    if logged_in?
    	User.from_omniauth(env["omniauth.auth"], current_user)
    	redirect_to request.referrer
    else
    	flash[:info] = "Please log in to baileysimms.com to continue. Thanks!"
    	redirect_to login_url
    end
  end

  def destroy
  	current_user.disconnect_from_facebook if logged_in? 
  	redirect_to request.referrer
  end

end