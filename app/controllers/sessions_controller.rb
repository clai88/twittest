class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params["user"]["email"])
    # fff
    if @user && @user.authenticate(params["user"]["password"])

      session[:user_id] = @user.id

      redirect_to(welcome_path)
    else
      redirect_to(login_path)
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to login_path
  end
end
