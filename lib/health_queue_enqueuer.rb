gem 'march_hare'

module HealthQueueEnqueuer

  def self.enqueue
    logger = Logger.new(STDOUT)
    thread_id = Thread.current.object_id
  
    logger.info "connecting to rabbitmq"
    connection = MarchHare.connect
    
    logger.info "creating rabbitmq channel"
    channel = connection.create_channel
    logger.info "creating webmon.healthcheck queue"
    queue = channel.queue('webmon.healthcheck', auto_delete: true) 

    # this just enqueues every health check regardless
    logger.info "pushing valid site test checks to rabbitmq"
    Site.all.pluck(:id).each do |site_id|
      queue.publish({ site_id: site_id }.to_json, routing_key: queue.name)
    end

    connection.close
  end

end
