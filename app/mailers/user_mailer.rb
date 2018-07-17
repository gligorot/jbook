class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_mail.subject
  #
  def welcome_mail(user)
    @url = "jjsocial.herokuapp.com"

    mail to: user.email, subject: "Welcome to JJSocial!"
  end
end
