class UserMailer < ApplicationMailer
  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end
end
