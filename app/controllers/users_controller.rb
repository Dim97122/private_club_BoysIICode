class UsersController < ApplicationController
    def new
    end

    def create
        user = User.create(email: params[:user][:email], password: params[:user][:password])
        if user.new_record? == false
            log_in user
            params[:user][:remember_me] == '1' ? remember(user) : forget(user)
            flash[:success] = 'Utilisateur créé'
            redirect_to '/'
        else
            flash[:danger] = 'Ya un problème mon coco'
        end
    end

    def show
        @user = User.find(params[:id])
        if current_user.id != @user.id
            flash[:danger] = 'Touche pas à ça coquin'
            redirect_to '/'
        end
    end

    def edit
        @user = User.find(params[:id])
        if current_user.id != @user.id
            flash[:danger] = 'Touche pas à ça coquin'
            redirect_to '/'
        end
    end

    def update
        @user = User.find(params[:id])
        user_params = params.require(:user).permit(:email, :password, :password_confirmation)
        if @user.update_attributes(user_params)
            flash[:success] = 'Compte modifié'
            redirect_to '/'
        else
            flash[:danger] = 'Ya un problème mon coco'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'Compte supprimé'
        redirect_to '/'
    end

    def index
        @users = User.all
    end

end