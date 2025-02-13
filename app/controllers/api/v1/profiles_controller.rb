class Api::V1::ProfilesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :authenticate_user!

    def index
        @profiles = Profile.all
        render json: @profiles
    end

    def show
        @profile = Profile.find(params[:id])
        render json: @profile
    end

    def update
        if @profile.update(profile_params)
            render json: @profile, status: :ok
        else
            render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def create
        user = User.find_by_jti(decrypt_payload[0]['jti'])
        profile = user.profile.new(profile_params)
    
        if profile.save
            render json: profile, status: :created
        else
            render json: profile.errors, status: :unprocessable_entity
        end
    end

    private

    def set_profile
        @profile = Profile.find_by(user_id: params[:id])
    end

    def profile_params
        params.require(:profile).permit(:name, :date_of_birth, :faculty, :country, :languages, :program_type, :gender)
    end

    def decrypt_payload
        jwt = request.headers["Authorization"]
        token = JWT.decode(jwt, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: 'HS256' })
    end
end
