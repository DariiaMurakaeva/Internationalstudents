class Api::V1::DiscussionsController < ApplicationController

    def index
        @discussions = Discussion.all
        render json: @discussions
    end

    def show
        @discussion = Discussion.find(params[:id])
    end

end
