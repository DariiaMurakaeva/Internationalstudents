class DiscussionsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    # GET /discussions or /discussions.json
    def index
        @discussions = Discussion.all
    end

    # GET /discussions/1 or /discussions/1.json
    def show
        @discussion = Discussion.find(params[:id])
    end

    def new
        @discussion = Discussion.new
    end
    
    def edit
    end
    
    def create
        @discussion = current_user.discussions.new(discussion_params)
    
        respond_to do |format|
            if @discussion.save
                format.html { redirect_to [:admin, @discussion], notice: "Discussion was successfully created." }
                format.json { render :show, status: :created, location: @discussion }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @discussion.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def update
        respond_to do |format|
            if @discussion.update(discussion_params)
                format.html { redirect_to [:admin, @discussion], notice: "Discussion was successfully updated." }
                format.json { render :show, status: :ok, location: @discussion }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @discussion.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @discussion.destroy!
    
        respond_to do |format|
            format.html { redirect_to admin_discussions_path, status: :see_other, notice: "Discussion was successfully destroyed." }
            format.json { head :no_content }
        end
    end
    
    private
        def set_discussion
            @discussion = Discussion.find(params[:id])
        end
    
        def discussion_params
            params.require(:discussion).permit(:user_id, :title, :content, :tags, :discussion_image)
        end
end