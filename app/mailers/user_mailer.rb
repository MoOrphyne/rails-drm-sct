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
    @packs = params[:packs]

    mail to: @user.email, subject: 'You just subscribe to the Drum Society'
  end

  def download_link
    @user = params[:user]
    @link = params[:link]
    @pack = params[:pack]

    mail to: @user.email, subject: "Drum Society - Download link (#{@pack.title})"
  end

  def new_pack
    @user = params[:user]
    @pack = params[:pack]

    mail to: @user.email, subject: 'Drum Society - A new pack added to your account'
  end
end
