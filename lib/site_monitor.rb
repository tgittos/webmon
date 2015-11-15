class SiteMonitor

  def self.update!
    begin
      Rails.logger.info "[Site Monitor] Starting check..."
      Site.all.each do |site|
        errors = []
        Rails.logger.info "[Site Monitor] Checking #{site.url}"
        site.tests.each do |test|
          result = test.check!
          errors << result unless result.result
        end
        if errors.count > 0
          Rails.logger.info "[Site Monitor] Sending rolled_up_failure email for errors: #{errors.inspect}"
          if !ENV['WEBMON_NO_EMAIL']
            AlertMailer.rolled_up_failure(site.user, site, errors).deliver_now
          else
            Rails.logger.info "WEBMON_NO_EMAIL set, not sending email alerts"
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
