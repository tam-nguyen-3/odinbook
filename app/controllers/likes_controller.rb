class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    if @post.likes.exists?(user: current_user)
      redirect_to @post, alert: "You have already liked."
      return
    end

    @like = @post.likes.build
    @like.user = current_user

    if @like.save
      redirect_to @post, notice: "Liked!"

    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])

    unless @post.likes.exists?(user: current_user)
      redirect_to @post, alert: "You haven't liked the post."
      return
    end

    @like = Like.find_by(post: @post, user: current_user)
    @like.destroy

    redirect_to @post
  end
end
