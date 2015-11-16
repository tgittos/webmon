class AlertMailer < ApplicationMailer

  default from: ENV["from"]

  def rolled_up_failure(user, site, errors)
    @user = user
    @site = site
    @errors = errors
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" has errors"
  end

  def clear(user, site, incident)
    @user = user
    @site = site
    @incident = incident
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" OK"
  end

end
