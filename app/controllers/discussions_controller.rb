class DiscussionsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :set_discussion, only: %i[ show edit update destroy bookmark]

    # GET /discussions or /discussions.json
    def index
        @discussion = Discussion.new
        @discussions = Discussion.order(created_at: :desc)

        respond_to do |format|
            format.html
            format.js
        end
    end

    # GET /discussions/1 or /discussions/1.json
    def show
        @discussion = Discussion.find(params[:id])

        if @discussion.nil?
            redirect_to discussions_path, alert: 'Discussion not found.'
        end
    end

    def new
        @discussion = Discussion.new

        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def edit
    end
    
    def create
        @discussion = current_user.discussions.new(discussion_params)

        @discussion.tag = case @discussion.tag
        when 'обучение'
            'обучение'
        when 'культура'
            'культура'
        when 'быт'
            'быт'
        when 'документы'
            'документы'
        else
            nil
        end

        respond_to do |format|
            if @discussion.save
                format.html { redirect_to @discussion }
                format.json { render :show, status: :created, location: @discussion }
                format.js   # This will look for `create.js.erb`
            else
                format.js { render :errors } # Ensure you handle errors properly
                format.html { render :new }
                format.json { render json: @discussion.errors, status: :unprocessable_entity }
            end
        end
    end
    
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
    
    def destroy
        @discussion.destroy!
    
        @discussion.destroy
        redirect_to discussions_path
        respond_to do |format|
            format.html { redirect_to discussions_path, status: :see_other, notice: "Discussion was successfully destroyed." }
            format.json { head :no_content }
        end
    end
    
    def bookmark
        bookmarks = @discussion.bookmarks.where(user_id: current_user.id)
    
        if bookmarks.count > 0
            bookmarks.destroy_all
        else
            @discussion.bookmarks.create(user_id: current_user.id)
        end
    
        redirect_back fallback_location: discussion_path(@discussion)
    end

    private
        def set_discussion
            @discussion = Discussion.find(params[:id])
        end
    
        def discussion_params
            params.require(:discussion).permit(:user_id, :title, :content, :tag)
        end
end