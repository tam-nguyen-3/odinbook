class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.avatar.attach(params[:avatar])
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.expect(user: [:name, :avatar])
  end
end
