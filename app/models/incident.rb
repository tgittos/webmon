class Incident < ActiveRecord::Base
  belongs_to :site
  has_many :incident_tests
  has_many :tests, through: :incident_tests

  scope :active, ->() { where(cleared_at: nil) }

  after_create :send_alert_email

  def clear
    self.cleared_at = Time.now
    self.save
    send_clear_email
  end

  def send_alert_email
    return if !tests.first.site.user.send_emails
    errors = incident_tests.collect{|it| it.test.test_results.latest }
    AlertMailer.rolled_up_failure(site.user, site, errors).deliver_now
  end

  def send_clear_email
    return if !tests.first.site.user.send_emails
    AlertMailer.clear(site.user, site, self).deliver_now
  end

end
