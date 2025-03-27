class Api::V1::ApplicationFormsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user
    skip_before_action :verify_authenticity_token, only: [:create]
    
    def index
        if @current_user.admin?
            @application_forms = ApplicationForm.includes(:student, :buddy)
        elsif @current_user.buddy?
            @application_forms = ApplicationForm.all
        elsif @current_user.international_student?
            @application_forms = current_user.application_form_as_student ? [current_user.application_form_as_student] : []
        else
            render json: { error: 'Forbidden' }, status: :forbidden
            return
        end
        
        render json: @application_forms, include: [:student, :buddy], status: :ok
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

    def set_current_user
        @current_user = current_user
    end

    def application_form_params
        params.require(:application_form).permit(:about, :date_of_arrival, :time_of_arrival, :place_of_arrival)
    end
end