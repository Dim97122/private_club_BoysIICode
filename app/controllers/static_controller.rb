class StaticController < ApplicationController
    def home
    end

    def secret
        if logged_in? == false
            flash[:danger] = 'hey login-toi pour y accéder'
            redirect_to '/'
        end
    end
end
