class Api::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
    
    def create
        @user = User.new(sign_up_params)
        @user.build_profile(profile_params) 
    
        if @user.save
            render json: {
                messages: "Sign Up Successfully",
                is_success: true,
                jwt: encrypt_payload
            }, status: :ok
        else
            render json: {
                messages: "Sign Up Failed",
                is_success: false
            }, status: :unprocessable_entity
        end
    end
    
    private
    
    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :user_role)
    end
    
    def profile_params
        params.require(:profile).permit(:name, :date_of_birth, :faculty, :country, :languages, :program_type, :gender)
    end

    def encrypt_payload
        payload = @user.as_json(only: [:email, :jti])
        token = JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!, 'HS256')
    end
end
