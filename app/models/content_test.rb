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
    test_result.value = page_content
    test_result.save!
    test_result
  end
  
  def to_s
    "page content #{comparison} \"#{content}\""
  end

end
