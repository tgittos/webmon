def in_server?
  !defined?(Rails::Console) && !(File.basename($0) == "rake")
end

if in_server? && !ENV['WEBMON_NO_CHECK']
  num_threads = 4
  Rails.logger.info "Starting #{num_threads} SiteMonitor thread/s"
  # create 4 threads
  num_threads.times.collect do
    Thread.new do
      while true
        ActiveRecord::Base.connection_pool.with_connection do
          SiteMonitor.new.work_queue
        end
        sleep 5
      end
    end
  end
else
  Rails.logger.info "Detected not in server or WEBMON_NO_CHECK set, not starting monitor schedules"
end

def graceful_shutdown
  Rails.logger.info "Exiting #{@threads.count} SiteMonitor thread/s"
  @threads.map(&:exit)
end

Signal.trap("INT") { 
  graceful_shutdown
  exit
}

Signal.trap("TERM") {
  graceful_shutdown
  exit
}
