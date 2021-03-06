class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  def welcome_email(user)
    @user = user
    @url = '.login'

    mail(to: @user.email, subject: 'Welcome to Twittest')
  end

  def new_follower_email(follower,followee)
    @follower = follower
    @followee = followee

    mail(to: @followee.email, subject: 'New Follower!')
  end
end
