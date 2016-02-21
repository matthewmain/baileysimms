class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Awesome. You're in."
      redirect_to root_url
    else
      flash[:danger] = "Sorry. This activation link has expired or is invalid."
      redirect_to root_url
    end
  end

end
