class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		#log in user, redirect to user's show page
  	else
  		flash.now[:danger] = 'Sorry. Invalid email or password. Try again.'
  		render 'new'
  	end
  end

  def destroy
  end

end
