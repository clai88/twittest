class FollowUsersController < ApplicationController
  def index
    followed = FollowUser.where(follower_id: session[:user_id])

    #getting the tweets of people you followed.  tried to do this more efficiently, but other ways broke it.
    ids = []
    followed.each {|i| ids.push(i.followee_id)}

    user_list = []
    ids.each do |i|
      if User.find_by(id: i) != nil
        user_list.push(User.find_by(id: i))
      end
    end
    @tweets = []
    user_list.each do |user|
      user.tweets.each do |tweet|
        @tweets.push(tweet)
      end
    end
    @tweets.sort_by{ |tweet| tweet.updated_at }



  end
  def create
    if session[:user_id] == params[:user_to_follow_id].to_i
      flash[:notice] = "You cannot follow yourself"
    else
      FollowUser.create(follower_id: session[:user_id],followee_id: params[:user_to_follow_id])
    end

    redirect_to profile_path(params[:user_to_follow_id])
  end

  def destroy
    FollowUser.find_by(follower_id: session[:user_id], followee_id: params[:user_to_follow_id]).destroy

    redirect_to profile_path(params[:user_to_follow_id])
  end
end
