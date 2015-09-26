class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "Starting site check..."
      Rails.logger.info "Done!"
    rescue Exception => e
      Rails.logger.info "Error running site check: #{e.message}: #{e.backtrace.join("\n")}"
    finally
      Rails.logger.flush
    end
  end

end
