class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Utilisateur loggé'
      redirect_to '/'
    else
      flash[:success] = 'Ya un problème mon coco'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Utilisateur déloggé'
    redirect_to '/'
  end
end