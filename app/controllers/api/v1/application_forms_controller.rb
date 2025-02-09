class Api::V1::ApplicationFormsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    
    def index
        @application_forms = ApplicationForm.all
    end

    def create
        user = User.find_by_jti(decrypt_payload[0]['jti'])
        application_form = user.application_forms.new(application_form_params)
        
        if application_form.save
            render json: application_form, status: :created
        else
            render json: application_form.errors, status: :unprocessable_entity
        end
    end
    
    private

    def application_form_params
        params.require(:application_form).permit(:about, :date_of_arrival, :time_of_arrival, :place_of_arrival, :place_of_residence, :note)
    end

    def decrypt_payload
        jwt = request.headers["Authorization"]
        token = JWT.decode(jwt, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: 'HS256' })
    end
end
