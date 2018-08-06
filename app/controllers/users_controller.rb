class UsersController < ApplicationController
    def new
    end

    def create
        user = User.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email], password: params[:user][:password])
        if user.new_record? == false
            log_in user
            params[:user][:remember_me] == '1' ? remember(user) : forget(user)
            flash[:success] = 'You\'ve successfully been added to the Member List'
            redirect_to '/'
        else
            flash[:danger] = 'We\'re sorry but there is obviously a problem with your registration... Please try agan!'
        end
    end

    def show
        @user = User.find(params[:id])
        if current_user.id != @user.id
            flash[:danger] = 'You\'re not allowed to do this kind of action'
            redirect_to '/'
        end
    end

    def edit
        @user = User.find(params[:id])
        if current_user.id != @user.id
            flash[:danger] = 'You\'re not allowed to do this kind of action'
            redirect_to '/'
        end
    end

    def update
        @user = User.find(params[:id])
        user_params = params.require(:user).permit(:email, :password, :password_confirmation)
        if @user.update_attributes(user_params)
            flash[:success] = 'Account successfully updated!'
            redirect_to '/'
        else
            flash[:danger] = 'We\'re sorry but there is obviously a problem with your registration... Please try agan!'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'Account successfully deleted. Hope to see you again!!'
        redirect_to '/'
    end

    def index
        @users = User.all
    end

end
