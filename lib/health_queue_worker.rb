module HealthQueueWorker

  def self.work
    logger = Logger.new(STDOUT)
    thread_id = Thread.current.object_id
    # do the work
    logger.info "[#{thread_id}] working the queue"
  end

end
