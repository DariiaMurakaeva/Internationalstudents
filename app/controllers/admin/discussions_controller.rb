class Admin::DiscussionsController < ApplicationController
    load_and_authorize_resource

    def index
        @discussions = Discussion.all
    end
end