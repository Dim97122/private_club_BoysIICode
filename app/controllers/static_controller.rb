class StaticController < ApplicationController
    def home
    end

    def home_club
        if logged_in? == false
            flash.now[:danger] = 'You\'re not allowed to go there'
            redirect_to '/'
        end
    end
end
