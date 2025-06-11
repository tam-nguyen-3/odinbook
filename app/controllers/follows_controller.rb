class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    followed_user = User.find(params[:user_id]) # clicked user

    if current_user.following.include?(followed_user)
    end

    @follow = current_user.following_relationships.build(followed: followed_user)

    if @follow.save
      redirect_to users_path, notice: "Followed!"
    else
      render users_path,  status: :unprocessable_entity
    end
  end

  def destroy
    followed_user = User.find(params[:user_id])

    unless current_user.following.include?(followed_user)
      return
    end

    follow = current_user.following_relationships.find_by(followed_id: followed_user.id)
    follow.destroy

    redirect_to users_path
  end
end
