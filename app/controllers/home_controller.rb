class HomeController < ApplicationController 

  def index
    @posts_cards = Post.where(id: [2, 3, 8])
  end 

  def about
  end
end
