class Api::V1::RegistrationsController < ApplicationController
    def create
        @user = User.new(sign_up_params)
        @user.build_profile(profile_params) 
    
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private
    
    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :user_role)
    end
    
    def profile_params
        params.require(:profile).permit(:name, :date_of_birth, :faculty, :country, :languages, :program_type, :gender)
    end
end
