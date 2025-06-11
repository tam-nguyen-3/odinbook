class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added!"

    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
