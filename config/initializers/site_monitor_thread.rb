def in_server?
  !defined?(Rails::Console) && !(File.basename($0) == "rake")
end

def spawn_queue_workers
  num_threads = 4
  Rails.logger.info "Starting #{num_threads} SiteMonitor thread/s"
  # create 4 threads
  num_threads.times.collect do
    Thread.new do
      #while true
        ActiveRecord::Base.connection_pool.with_connection do
          HealthQueueWorker::work
        end
      #  sleep 5 # remove this when we go live
      #end
    end
  end 
end

def spawn_enqueuer
  Thread.new do
    while true
      ActiveRecord::Base.connection_pool.with_connection do
        HealthQueueEnqueuer::enqueue
      end
      # sleep for 15 minutes, replicating current functionality but
      # with a rabbitmq queue
      sleep 15 * 60 * 60
    end
  end
end

# this should probably be in a different initializer
def init_rabbitmq_channel
  connection = Bunny.new(host: 'localhost')
  connection.start
  channel = connection.create_channel
  connection.stop
end

if in_server? && !ENV['WEBMON_NO_CHECK']
  spawn_queue_workers
  spawn_enqueuer
else
  Rails.logger.info "Detected not in server or WEBMON_NO_CHECK set, not starting monitor schedules"
end
