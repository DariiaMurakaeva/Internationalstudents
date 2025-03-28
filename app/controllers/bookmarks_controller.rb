class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def bookmark
    @post = Post.find(params[:id])
    bookmark = current_user.bookmarks.create(bookmarkable: @post)
    respond_to do |format|
      format.json { render json: { bookmarked: true } }
    end
  end

  def unbookmark
    @post = Post.find(params[:id])
    bookmark = current_user.bookmarks.find_by(bookmarkable: @post)
    bookmark&.destroy
    respond_to do |format|
      format.json { render json: { bookmarked: false } }
    end
  end
end
