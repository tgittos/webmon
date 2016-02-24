class SiteMonitor

  def self.check_site(site_id)
    Rails.logger.info "[Site Monitor] Starting check..."
    site = Site.find(site_id)
    errors = []
    site.tests.each do |test|
      result = test.test_results.new
      begin
        Timeout.timeout(30) do
          Rails.logger.info "[Site Monitor] Running test #{test.to_s} for site #{site.url}"
          result = test.check!
        end
      rescue Timeout::Error
        Rails.logger.info "[Site Monitor] Test \"#{test.to_s}\" for site #{site.url} timed out!"
        result.result = false
        result.reason = TestResult::TEST_ERRORED_REASON
        result.value = "Test timed out!"
        result.save
      rescue Exception => e
        Rails.logger.error "[Site Monitor] Error running test \"#{test.to_s}\" for #{site.url}: #{e.message}: #{e.backtrace.join("\n")}"
        result.result = false
        result.reason = TestResult::TEST_ERRORED_REASON
        result.value = e.message
        result.save
      ensure
        if !result.result
          # lets add to the errors if the error threshold has been hit
          results = Array.wrap(test.test_results.newest_first.take(test.failure_threshold)).collect{|tr| tr.result}
          if results.count == test.failure_threshold && test.incidents.active.count == 0 && !results.include?(true)
            errors << result unless result.result
          end
        else
          # lets clear the incident if the clear threshold has been hit
          results = Array.wrap(test.test_results.newest_first.take(test.clear_threshold)).collect{|tr| tr.result}
          if results.count == test.clear_threshold && test.incidents.active.count > 0 && !results.include?(false)
            test.incidents.last.clear
          end
        end
      end
    end
    if errors.count > 0
      Rails.logger.info "[Site Monitor] Sending rolled_up_failure email for errors: #{errors.inspect}"
      if !ENV['WEBMON_NO_EMAIL']
        incident = Incident.create site: site, tests: errors.collect{|e| e.test}
      else
        Rails.logger.info "WEBMON_NO_EMAIL set, not sending email alerts"
      end
    end

    Rails.logger.info "[Site Monitor] Done!"
  end

end
