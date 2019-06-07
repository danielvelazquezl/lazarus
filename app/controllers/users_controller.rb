class UsersController < ApplicationController

    def index
        @user = User.all_user
    end


end
