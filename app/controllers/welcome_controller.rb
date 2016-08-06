class WelcomeController < ApplicationController
  def index
    @tweets = Tweet.all.order(updated_at: :desc)
    @user = current_user
  end
end
