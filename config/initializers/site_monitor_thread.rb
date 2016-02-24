#require './lib/test'

def in_server?
  !defined?(Rails::Console) && !(File.basename($0) == "rake")
end

@threads = []

if in_server? && !ENV['WEBMON_NO_CHECK']
  num_threads = 4
  Rails.logger.info "Starting #{num_threads} SiteMonitor thread/s"
  # create 4 threads
  @threads = num_threads.times.collect do
    Thread.new do
      while true
      puts "[#{Thread.current.object_id}] working a queue"
      #SiteMonitor.new.work_queue
      sleep 10
      end
    end
  end
  Rails.logger.info "Threads: #{@threads.inspect}"
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
