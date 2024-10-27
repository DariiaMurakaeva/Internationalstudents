class Admin::CommentsController < ApplicationController
    before_action :set_commentable

    def create
        @comment = @commentable.comments.build(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            redirect_to polymorphic_path([:admin, @commentable])
        else
            redirect_to polymorphic_path([:admin, @commentable])
        end
    end

    def destroy
        @comment = @commentable.comments.find(params[:id])
        @comment.destroy
        redirect_to polymorphic_path([:admin, @commentable])
    end


    def set_commentable
        if params[:post_id]
            @commentable = Post.find(params[:post_id])
        elsif params[:discussion_id]
            @commentable = Discussion.find(params[:discussion_id])
        end
    end

    def comment_params
        params.require(:comment).permit(:user_id, :body)
    end
end
