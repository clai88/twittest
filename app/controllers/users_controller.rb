class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.sign_up(params.require(:user).permit(:email, :password, :name, :password_confirmation))

    if @user.valid?
      flash[:notice] = 'User was successfully created.'
      UserMailer.welcome_email(@user).deliver_now
      redirect_to(login_path)
    else
      render :new
    end
  end
end
