require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

def in_server?
  !defined?(Rails::Console) && !(File.basename($0) == "rake")
end

if in_server? && !ENV['WEBMON_NO_CHECK']
  Rails.logger.info "Scheduling SiteMonitor to run every 15m"
  scheduler.every("15m") do
    SiteMonitor.update!
  end
else
  Rails.logger.info "Detected not in server or WEBMON_NO_CHECK set, not starting monitor schedules"
end

