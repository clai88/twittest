class FollowUsersController < ApplicationController
  def create
    FollowUser.create(follower_id: session[:user_id],followee_id: params[:user_to_follow_id])

    redirect_to profile_path(params[:user_to_follow_id])
  end

  def destroy
    FollowUser.find_by(follower_id: session[:user_id], followee_id: params[:user_to_follow_id]).destroy

    redirect_to profile_path(params[:user_to_follow_id])
  end
end
