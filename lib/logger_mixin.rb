module LoggerMixin

  def self.included(klass)
    extend ClassMethods
  end

  module ClassMethods

    def log(message, level = :info)
      @@logger ||= Logger.new(STDOUT)
      thread_id = Thread.current.object_id
      @@logger.send(level, "[#{thread_id}] #{message}")
    end

  end

end
