class UserMailer < ApplicationMailer
  def reset_password_email
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
