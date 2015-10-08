class AlertMailer < ApplicationMailer

  default from: ENV["from"]

  def alert_email(user)
    @user = user
    mail to: @user.email,
         subject: "Sample Mail using Mailgun SMTP"
  end

end
