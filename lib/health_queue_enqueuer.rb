module HealthQueueEnqueuer

  def self.enqueue
    logger = Logger.new(STDOUT)
    thread_id = Thread.current.object_id
    # do the work
    logger.info "filling the queue"
  end

end
