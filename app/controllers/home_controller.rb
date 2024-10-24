class HomeController < ApplicationController 

  def index  
    @discussions = Discussion.all  
    @posts = Post.all  
  end  

  def about
  end
end
