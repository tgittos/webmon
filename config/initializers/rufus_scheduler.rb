require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

if ENV['RAILS_ENV'] != 'test' && !ENV['WEBMON_NO_CHECK']
  Rails.logger.info "Scheduling SiteMonitor to run every 15m"
  SiteMonitor.update!
  scheduler.every("15m") do
    SiteMonitor.update!
  end
else
  Rails.logger.info "Detected test env or WEBMON_NO_CHECK set, not starting monitor schedules"
end
