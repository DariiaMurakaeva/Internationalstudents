class Api::V1::ProfilesController < ApplicationController
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

    private

    def set_profile
        @profile = Profile.find_by(user_id: params[:id])
    end

    def profile_params
        params.require(:profile).permit(:name, :date_of_birth, :faculty, :country, :languages, :program_type, :gender)
    end
end
