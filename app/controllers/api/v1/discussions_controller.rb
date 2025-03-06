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

    #Поправить#
    def update
        respond_to do |format|
            if @discussion.update(discussion_params)
                format.html { redirect_to discussion_path(@discussion), notice: "Discussion was successfully updated." }
                format.json { render :show, status: :ok, location: @discussion }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @discussion.errors, status: :unprocessable_entity }
            end
        end
    end

    #Тут тоже, и в постах#
    def destroy
        @discussion.destroy!
    
        respond_to do |format|
            format.html { redirect_to discussion_path(@discussion), status: :see_other, notice: "Discussion was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    def discussion_params
        params.require(:discussion).permit( :user_id, :title, :content, :tag)
    end
end
