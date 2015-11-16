require 'rails_helper'
require 'site_monitor'

describe "site monitor" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")

    [:content_test, :response_test, :response_time_test].each do |test_type|
      FactoryGirl.create(test_type, site: @site) 
    end
  end

  it "runs each of the tests" do
    @site.reload
    puts "site.tests: #{@site.tests.inspect}"
    expect_any_instance_of(ContentTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    SiteMonitor.update!
  end

  it "tries to send a roll-up email when any tests fails" do
    expect(AlertMailer).to receive(:rolled_up_failure) { double("AlertMailer", deliver_now: true) }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ContentTest).to receive(:check!) { failed_test }
    SiteMonitor.update!
  end

  it "doesn't try to send an email if no tests fail" do
    expect(AlertMailer).to_not receive(:rolled_up_failure)
    expect_any_instance_of(ContentTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    SiteMonitor.update!
  end

  private

  def passed_test
    FactoryGirl.build(:test_result, result: true)
  end

  def failed_test
    FactoryGirl.build(:test_result, result: false)
  end

end
