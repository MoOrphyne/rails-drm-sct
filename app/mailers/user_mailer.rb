class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user]

    mail to: @user.email, subject: 'Welcome to the Drum Society'
  end

  def subscription
    @user = params[:user]

    mail to: @user.email, subject: 'You just subscribe to the Drum Society'
  end
end
