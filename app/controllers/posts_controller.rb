class PostsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :set_post, only: %i[ show edit update destroy bookmark]

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end
    
    def edit
    end
    
    def create
        # post_params.merge(project: { user_id: current_user.id })
        @post = current_user.posts.new(post_params)
    
        respond_to do |format|
            if @post.save
                format.html { redirect_to post_path(@post), notice: "Post was successfully created." }
                format.json { render :show, status: :created, location: @post }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def update
        respond_to do |format|
            if @post.update(post_params)
                format.html { redirect_to post_path(@post), notice: "Post was successfully updated." }
                format.json { render :show, status: :ok, location: @post }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: [:admin, @post], status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @post.destroy!
    
        respond_to do |format|
            format.html { redirect_to admin_posts_path, status: :see_other, notice: "Post was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    def bookmark 

        bookmarks = @post.bookmarks.where(user_id: current_user.id)
    
        if bookmarks.count > 0
            bookmarks.destroy_all
        else
            @post.bookmarks.create(user_id: current_user.id)
        end
    
        redirect_back fallback_location: post_path(@post)
    end


    private
    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit( :title, :content, :tags, :post_image, :tag_list)
    end
end