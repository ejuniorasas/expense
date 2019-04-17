class ApplicationController < ActionController::Base
    before_action :find_logged_user

    private
    def find_logged_user
        @user = User.first
    end
end
