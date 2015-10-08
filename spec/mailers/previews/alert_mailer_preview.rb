# Preview all emails at http://localhost:3000/rails/mailers/alert_mailer
class AlertMailerPreview < ActionMailer::Preview

  def content_test_failure_preview
    AlertMailer.content_test_failure(User.first, Site.first, Site.first.content_tests.first)
  end

  def status_failure_preview
    AlertMailer.status_failure(User.first, Site.first, Site.first.site_healths.first)
  end

end
