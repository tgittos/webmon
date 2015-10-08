class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "[Site Monitor] Starting check..."
      Site.all.each do |site|
        Rails.logger.info "[Site Monitor] Checking #{site.url}"
        result = site.check!
        if (result.http_response != 200)
          Rails.logger.info "[Site Monitor] Sending status_failure email for result: #{result.inspect}"
          AlertMailer.status_failure(site.user, site, result) 
        end
        site.content_tests.active.each do |content_test|
          Rails.logger.info "[Site Monitor] Running content test: #{content_test.comparison} \"#{content_test.content}\""
          result = content_test.check!
          unless result
            Rails.logger.info "[Site Monitor] Sending content_test_failure email for result: #{result.inspect}"
            AlertMailer.content_test_failure(site.user, site, content_test)
          end
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
