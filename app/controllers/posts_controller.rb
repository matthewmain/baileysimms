class PostsController < ApplicationController

  def index
    @posts = Post.all
    @intro_page = true
  end

  def new
  end

  def create
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
