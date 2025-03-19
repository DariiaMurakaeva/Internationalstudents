class Api::V1::ProfilesController < ApplicationController
    include Rails.application.routes.url_helpers

    skip_before_action :verify_authenticity_token, only: [:create]

    def index
        @profiles = Profile.all
        profiles_with_photos = @profiles.map do |profile|
            profile.as_json.merge({
                profile_photo_url: profile.profile_photo.attached? ? url_for(profile.profile_photo) : nil
            })
        end
        
        render json: profiles_with_photos
    end

    def show
        @profile = Profile.find(params[:id])
        render json: @profile.as_json.merge({
            profile_photo_url: @profile.profile_photo.attached? ? url_for(@profile.profile_photo) : nil
        })
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

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :faculty, :country, :languages, :program_type, :profile_photo)
    end
end
