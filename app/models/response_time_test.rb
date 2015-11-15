class ResponseTimeTest < Test
  
  def self.comparisons
    ["greater than", "less than"]
  end
  
  def check!
    test_status = test_results.new
    start_time = Time.now
    response = site.fetch
    response.body # eval body to get accurate time info
    finish_time = Time.now
    response_time = ((finish_time.to_f - start_time.to_f) * 1000.0).to_i
    test_status.result = !if self.comparison == "greater than"
      response_time > content.to_i
    else
      response_time < content.to_i
    end == false
    test_status.value = response_time
    test_status.save!
    test_status
  end
  
  def to_s
    "#{comparison} #{content}ms"
  end

end
