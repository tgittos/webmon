class ResponseTest < Test

  validates :content, numericality: { only_integer: true }
  
  def self.comparisons
    ["equals", "doesn't equal"]
  end
  
  def check!
    test_status = test_results.new
    response = site.fetch
    test_status.result = !if self.comparison == "equals"
      response.code.to_i == content.to_i
    else
      response.code.to_i != content.to_i 
    end == false
    test_status.reason = TestResult::TEST_FAILED_REASON unless test_status.result 
    test_status.value = response.code.to_i
    test_status.save!
    test_status
  end
  
  def to_s
    "HTTP status #{comparison} #{content}"
  end

end
