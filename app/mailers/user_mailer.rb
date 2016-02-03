class UserMailer < ApplicationMailer
  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: '...And stay out!')
  end
end
