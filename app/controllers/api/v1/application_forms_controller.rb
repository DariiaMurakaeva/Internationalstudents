class Api::V1::ApplicationFormsController < ApplicationController
    def index
        @application_forms = ApplicationForm.all
    end
end
