class ApplicationFormsController < ApplicationController
    before_action :authenticate_user!

    #depends on the user role
    def index
        if current_user.admin?
            @application_forms = ApplicationForm.includes(:student, :buddy)
        elsif current_user.buddy?
            @my_students = ApplicationForm.where(buddy_id: current_user.id)
            @application_forms = ApplicationForm.where(buddy_id: nil)
        elsif current_user.international_student?
            # @application_forms = [current_user.application_form_as_student]
            @application_forms = current_user.application_form_as_student ? [current_user.application_form_as_student] : []
            @application_form = ApplicationForm.new
        end
    end

    #for international students only
    def new
        @application_form = ApplicationForm.new
    end

    def create
        @application_form = current_user.create_application_form_as_student(application_form_params)
        if @application_form.save
            redirect_to application_forms_path, notice: 'Application submitted successfully.'
        else
            render :new
        end
    end

    #for buddies only
    def my_students
        @my_students = ApplicationForm.where(buddy_id: current_user.id)
    end

    def take_student
        application_form = ApplicationForm.find(params[:id])
        application_form.update(buddy_id: current_user.id)
        redirect_to my_students_path, notice: 'Теперь вы — бадди для этого студента'
    end

    private

    def application_form_params
        params.require(:application_form).permit(:about, :date_of_arrival, :time_of_arrival, :place_of_arrival, :place_of_residence, :note)
    end
end
