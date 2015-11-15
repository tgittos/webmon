class ResponseTest < Test
  
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
    test_status.value = response.code.to_i
    test_status.save!
    test_status
  end
  
  def to_s
    "#{comparison} #{content}"
  end

end
