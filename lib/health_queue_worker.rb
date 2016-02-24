gem 'march_hare'

module HealthQueueWorker

  def self.work
    logger = Logger.new(STDOUT)
    thread_id = Thread.current.object_id

    connection = MarchHare.connect
    
    channel = connection.create_channel
    queue = channel.queue('webmon.healthcheck', auto_delete: true) 

    # this just enqueues every health check regardless
    logger.info "[#{thread_id}] creating subscription to rabbitmq queue"
    queue.subscribe do |metadata, message|
      json = JSON.parse(message)
      site_id = json["site_id"]
      logger.info "[#{thread_id}] running check for site_id #{site_id}"
      SiteMonitor::check_site(site_id) 
    end
  end

end
