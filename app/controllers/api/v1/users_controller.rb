module Api::V1
  class UsersController < ApiController
    doorkeeper_for :all
    #skip_load_and_authorize_resource :only => [:index,:relationship]
    #authorize_resource

    def index
      @users = User.index.page params[:page]
      respond_with @users
    end

    def show
      @user = User.find(params[:id])
      render json: @user.as_json(type: :api_show,user: current_resource_owner)
    end

    def relationship
      @following = current_resource_owner.following
      @followers = current_resource_owner.followers
      @friend = current_resource_owner.friend
      render json: {following: @following, followers: @followers, friend: @friend}.to_json
    end

    def friend
      @users = current_resource_owner.friend
      respond_with @users
    end

    def follow
      @user = User.find(params[:id])
      if current_resource_owner.follow! @user
        render json: current_resource_owner.relationship(@user)
      else
        render json:{},status: 422
      end
    end

    def unfollow
      @user = User.find(params[:id])
      current_resource_owner.unfollow! @user
      redirect_to :back
    end
  end
end
