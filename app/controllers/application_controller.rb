class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def home
  end

  private      

    #confirms that a user is logged in
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "You'd better log in if you're going to try to do that sort of thing."
        redirect_to login_url
      end
    end


    #Facebook Omniauth session
    # def fb_current_user
    #   @fb_current_user ||= current_user if current_user[:oauth_token]
    # end
    # helper_method :fb_current_user					

end
