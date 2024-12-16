class Api::V1::DiscussionsController < ApplicationController

    def index
        @discussions = Discussion.all
    end

    def show
        @discussion = Discussion.find(params[:id])
    end

end
