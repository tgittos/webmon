class AlertMailer < ApplicationMailer

  default from: ENV["from"]

  def rolled_up_failure(user, site, errors)
    @user = user
    @site = site
    @errors = errors
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" has errors"
  end

end
