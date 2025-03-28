class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
        @users = User.all
    end

    private

    def require_admin
        unless current_user&.admin?
            redirect_to root_path, alert: "Not authorized"
        end
    end
end
