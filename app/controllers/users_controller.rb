class UsersController < ApplicationController
  before_filter :authenticate_user!
  #skip_load_and_authorize_resource :only => [:index,:relationship]
  authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def relationship
    @following = current_user.following
    @followers = current_user.followers
    @friend = current_user.friend
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow! @user
    redirect_to :back
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow! @user
    redirect_to :back
  end
end
