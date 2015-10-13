class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "[Site Monitor] Starting check..."
      Site.all.each do |site|
        errors = []
        Rails.logger.info "[Site Monitor] Checking #{site.url}"
        result = site.check!
        if (result.http_response != 200)
          #Rails.logger.info "[Site Monitor] Sending status_failure email for result: #{result.inspect}"
          errors << result
          #AlertMailer.status_failure(site.user, site, result).deliver_now 
        end
        site.content_tests.active.each do |content_test|
          Rails.logger.info "[Site Monitor] Running content test: #{content_test.comparison} \"#{content_test.content}\""
          content_result = content_test.check!
          unless (content_result.result)
            #Rails.logger.info "[Site Monitor] Sending content_test_failure email for result: #{content_result.inspect}"
            errors << content_test
            #AlertMailer.content_test_failure(site.user, site, content_test).deliver_now
          end
          if errors.count > 0
            Rails.logger.info "[Site Monitor] Sending rolled_up_failure email for errors: #{errors.inspect}"
            AlertMailer.rolled_up_failure(site.user, site, errors).deliver_now
          end
        end
      end
      Rails.logger.info "[Site Monitor] Done!"
    rescue Exception => e
      Rails.logger.info "[Site Monitor] Error running site check: #{e.message}: #{e.backtrace.join("\n")}"
    ensure
    end
  end

end
