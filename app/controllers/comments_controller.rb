class CommentsController < ApplicationController
    def create
        if params[:post_id]
            @post = Post.find(params[:post_id])
            @comment = @post.comments.create(params[:comment].permit(:user_id, :body))
            redirect_to post_path(@post)
        elsif params[:post_id]
            @discussion = Discussion.find(params[:discussion_id])
            @comment = @discussion.comments.create(params[:comment].permit(:user_id, :body))
            redirect_to discussion_path(@discussion) 
        end
    end


    def destroy
        if params[:post_id]
            @post = Post.find(params[:post_id])
            @comment = @post.comments.find(params[:id])
            @comment.destroy
            redirect_to post_path(@post)
        elsif params[:discussion_id]
            @discussion = Discussion.find(params[:post_id])
            @comment = @post.comments.find(params[:id])
            @comment.destroy
            redirect_to_discussion_path(@discussion)
        end
    end
end
