require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

Rails.logger.info "Scheduling SiteMonitor to run every 15m"
SiteMonitor.update!
scheduler.every("5m") do
  SiteMonitor.update!
end
