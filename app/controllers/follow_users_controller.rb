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
    @twets = @tweets.sort_by{ |tweet| tweet.updated_at }
  end
  def create
    follower = session[:user_id]
    followee = params[:user_to_follow_id].to_i
    if follower == followee
      flash[:notice] = "You cannot follow yourself"
    else
      FollowUser.create(follower_id: follower,followee_id: followee)
      follower = User.find_by(id: follower)
      followee = User.find_by(id: followee)
      UserMailer.new_follower_email(follower,followee).deliver_now
    end

    redirect_to profile_path(followee)
  end

  def destroy
    FollowUser.find_by(follower_id: session[:user_id], followee_id: params[:user_to_follow_id]).destroy

    redirect_to profile_path(params[:user_to_follow_id])
  end
end
