class AlertMailer < ApplicationMailer

  default from: ENV["from"]

  def content_test_failure(user, site, test)
    @user = user
    @site = site
    @test = test
    @result = test.test_statuses.latest
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" failed a content test"
  end

  def status_failure(user, site, status)
    @user = user
    @site = site
    @status = status
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" returned a non 200 status"
  end

  def rolled_up_failure(user, site, errors)
    @user = user
    @site = site
    @errors = errors
    mail to: @user.email,
         subject: "Webmon: \"#{@site.name}\" has errors"
  end

end
