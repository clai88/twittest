class WelcomeController < ApplicationController
  def index
    @tweets = Tweet.all
  end
end
