class Api::V1::DiscussionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def index
        @discussions = Discussion.all
    end

    def show
        @discussion = Discussion.find(params[:id])
    end

    def create
        user = User.find_by_jti(decrypt_payload[0]['jti'])
        post = user.discussions.new(discussion_params)
    
        if discussion.save
            render json: discussion, status: :created
        else
            render json: discussion.errors, status: :unprocessable_entity
        end
    end

    def update
        discussion = Discussion.find(params[:id])
        if discussion.update(discussion_params)
            render json: discussion, status: :ok
        else
            render json: discussion.errors, status: :unprocessable_entity
        end
    end

    def destroy
        discussion = Discussion.find(params[:id])
        if discussion.destroy
            head :no_content
        else
            render json: { error: "Failed to delete the discussion" }, status: :unprocessable_entity
        end
    end

    private

    def discussion_params
        params.require(:discussion).permit(:user_id, :title, :content, :tag)
    end
end
