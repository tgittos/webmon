class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "[Site Monitor] Starting check..."
      Site.all.each do |site|
        errors = []
        Rails.logger.info "[Site Monitor] Checking #{site.url}"
        site.tests.each do |test|
          begin
            Timeout.timeout(30) do
              Rails.logger.info "[Site Monitor] Running test #{test.to_s}"
              result = test.check!
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
          rescue Timeout::Error
            Rails.logger.info "[Site Monitor] Test \"#{test.to_s}\" timed out!"
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
      end
      Rails.logger.info "[Site Monitor] Done!"
    rescue Exception => e
      Rails.logger.error "[Site Monitor] Error running site check: #{e.message}: #{e.backtrace.join("\n")}"
    ensure
    end
  end

end
