module ApplicationHelper

  def site_css_class(site)
    results = site.tests.collect{|t| t.test_results.latest}
                        .collect{|tr| tr.result}
                        .uniq
    if results.include?(true) && results.include?(false)
      "warning"
    elsif results.include?(true)
      "ok"
    elsif results.include?(false)
      "error"
    end
  end

  def test_css_class(test)
    if test.test_results.latest.result
      "ok"
    else
      "error"
    end
  end

  def test_result_css_class(test_result)
    if test_result.result
      "ok"
    else
      "error"
    end
  end

  def site_test_path(site, test)
    if test.is_a? ContentTest
      site_content_test_path(site, test)
    elsif test.is_a? ResponseTest
      site_response_test_path(site, test)
    elsif test.is_a? ResponseTimeTest
      site_response_time_test_path(site, test)
    end
  end
  
end
