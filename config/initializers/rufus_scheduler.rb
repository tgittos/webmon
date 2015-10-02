require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

Rails.logger.info "Scheduling SiteMonitor to run every 15m"
SiteMonitor.update!
scheduler.every("15m") do
  SiteMonitor.update!
end
