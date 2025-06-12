class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(user: current_user.following).or(Post.where(user: current_user)).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.images.attach(params[:images])

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.expect(post: [ :content, images: [] ])
    end
end
