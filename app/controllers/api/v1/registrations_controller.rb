class Api::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
    
    def create
        @user = User.new(sign_up_params)
        
        # Изменяем способ создания профиля
        if params[:user][:profile_attributes].present?
            @user.build_profile(profile_attributes_params)
        end
    
        if @user.save
            render json: {
                messages: "Sign Up Successfully",
                is_success: true,
                jwt: encrypt_payload
            }, status: :ok
        else
            render json: {
                messages: "Sign Up Failed",
                is_success: false,
                errors: @user.errors.full_messages
            }, status: :unprocessable_entity
        end
    end
    
    private
    
    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :user_role)
    end
    
    # Заменяем profile_params на profile_attributes_params
    def profile_attributes_params
        params.require(:user).require(:profile_attributes).permit(
            :first_name, 
            :last_name, 
            :date_of_birth, 
            :faculty, 
            :country, 
            :languages, 
            :program_type, 
            :profile_photo
        )
    end

    def encrypt_payload
        payload = @user.as_json(only: [:email, :jti])
        token = JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!, 'HS256')
    end
end