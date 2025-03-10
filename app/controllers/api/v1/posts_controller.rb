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
        post = Post.find(params[:id])
        if discussion.update(post_params)
            render json: post, status: :ok
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end

    def destroy
        post = Post.find(params[:id])
        if post.destroy
            head :no_content
        else
            render json: { error: "Failed to delete the post" }, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit( :title, :content, :tags, :post_image)
    end
end
