class Api::V1::PostsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def create
        user = User.find_by_jti(decrypt_payload[0]['jti'])
        post = user.posts.new(post_params)
    
        if post.save
            render json: post, status: :created
        else
            render json: post.errors, status: :unprocessable_entity
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

    private

    def post_params
        params.require(:post).permit( :title, :content, :tags, :post_image)
    end
end
