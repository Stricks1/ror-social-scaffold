class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def whatever
    @user = User.find(params[:id])
    current_user.request_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Success'
  end
end
