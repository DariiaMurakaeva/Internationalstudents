class HomeController < ApplicationController 

  def index  
    @posts_cards = Post.where(id: [2, 6, 4])
    @discussions_cards = Discussion.where(id: [2, 6, 4, 7,8,9])
    @discussions = Discussion.all  
    @posts = Post.all  
  end  

  def about
  end
end
