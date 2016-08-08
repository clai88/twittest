class TweetsController < ApplicationController
  def index
    @tweets = Tweet.where(user_id: session[:user_id]).order(updated_at: :desc)
    @users = User.all
  end

  def new
    unless current_user
      redirect_to welcome_path
      return
    end
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = session[:user_id]

    if @tweet.save
      redirect_to tweet_path(@tweet.id)
    else
      render :new
    end
  end

  def show
    @tweet= Tweet.find_by(id: params["id"])
  end

  def edit
    tweets = Tweet.where(user_id: session[:user_id])
    @tweet= tweets.find_by(id: params["id"])
  end

  def update
    tweets = Tweet.where(user_id: session[:user_id])
    @tweet= tweets.find_by(id: params["id"])

    @tweet.update(tweet_params)
    redirect_to tweets_path
  end

  def destroy
    tweets = Tweet.where(user_id: session[:user_id])
    tweets.find_by(id: params["id"]).destroy

    redirect_to tweets_path
  end

  def profile
    @user = User.find_by(id: params[:user_id])
    @tweets = Tweet.where(user_id: @user.id).order(updated_at: :desc)
  end

  private def tweet_params
    params.require("tweet").permit(:body, :user_id)
  end


end
