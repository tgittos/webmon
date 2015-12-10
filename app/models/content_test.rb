class ContentTest < Test 

  def self.comparisons
    ["matches", "doesn't match"]
  end

  def check!
    test_result = test_results.new
    page_content = site.fetch_body
    test_result.result = !if self.comparison == "matches"
      page_content =~ /#{content}/
    else
      page_content !~ /#{content}/
    end == false
    begin
      page_content.encode!("UTF-8")
      test_result.value = page_content
    rescue Exception => e
      # naughty, string is not actually UTF-8. Ignore the string!
      Rails.logger.info "String can't convert to UTF-8, lets not worry about storing it."
    end
    test_result.save!
    test_result
  end
  
  def to_s
    "page content #{comparison} \"#{content}\""
  end

end
