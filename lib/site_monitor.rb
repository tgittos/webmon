class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "[Site Monitor] Starting check..."
      Site.all.each do |site|
        Rails.logger.info "[Site Monitor] Checking #{site.url}"
        site.check!
        site.content_tests.each do |content_test|
          Rails.logger.info "[Site Monitor] Running content test: #{content_test.comparison} \"#{content_test.content}\""
          content_test.check!
        end
      end
      Rails.logger.info "[Site Monitor] Done!"
    rescue Exception => e
      Rails.logger.info "[Site Monitor] Error running site check: #{e.message}: #{e.backtrace.join("\n")}"
    ensure
      Rails.logger.flush
    end
  end

end
