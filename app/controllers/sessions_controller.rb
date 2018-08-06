class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'You are now logged in'
      redirect_to '/'
    else
      flash[:notice] = 'Obviously something went wrong...'
    end
  end

  def destroy
    log_out
    flash[:success] = 'You\'ve been logged out'
    redirect_to '/'
  end
end
