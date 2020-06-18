class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def frequest
    @user = User.find(params[:id])
    current_user.request_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Success'
  end

  def accept
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Accepted Friendship'
  end

  def reject
    @user = User.find(params[:id])
    current_user.reject_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Rejected Friendship'
  end
end
