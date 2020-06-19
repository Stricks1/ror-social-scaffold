class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.request_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Success'
  end

  def update
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Accepted Friendship'
  end

  def destroy
    @user = User.find(params[:id])
    current_user.reject_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'Rejected Friendship'
  end
end