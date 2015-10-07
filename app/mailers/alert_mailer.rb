class AlertMailer < ApplicationMailer

  def alert_email(user)
    @user = user
    Rails.logger.info "[Alert Mailer] sending email to #{@user.email}"
    result = send_via_mg(user)
    Rails.logger.info "[Alert Mailer] result: #{result.inspect}" 
  end

  private

  def send_via_mg(user)
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = { from:    ENV['from'],
                       to:      @user.email,
                       subject: 'Sample Mail using Mailgun API',
                       text:    'This mail is sent using Mailgun API via mailgun-ruby' }
    mg_client.send_message ENV['domain'], message_params
    mg_client.get("#{ENV['domain']}/events", { event: 'delivered' })
  end

end
