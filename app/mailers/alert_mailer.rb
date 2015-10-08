class AlertMailer < ApplicationMailer

  def alert_email(user)
    @user = user
    Rails.logger.info "[Alert Mailer] sending email to #{@user.email}"
    result = send_via_mg(user)
    Rails.logger.info "[Alert Mailer] result: #{result.inspect}" 
  end

  private

  def send_via_mg(user)
    #mg_client = Mailgun::Client.new ENV['api_key']
    #message_params = { from:    ENV['from'],
    #                   to:      @user.email,
    #                   subject: 'Sample Mail using Mailgun API',
    #                   html:    render_email_html.to_str } 
    #mg_client.send_message ENV['domain'], message_params
    #mg_client.get("#{ENV['domain']}/events", { event: 'delivered' })
  end

  def render_email_html
    ActionView::Base.new(Rails.configuration.paths["app/views"].first).render(
      partial: "alert_mailer/alert_email", format: :html,
      locals: { user: @user }
    )
  end

end
