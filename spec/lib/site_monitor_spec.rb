require 'rails_helper'
require 'site_monitor'

describe "site monitor" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")

    [:content_test, :response_test, :response_time_test].each do |test_type|
      FactoryGirl.create(test_type, site: @site) 
    end
    
    @site.reload
  end

  it "runs each of the tests" do
    expect_any_instance_of(ContentTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    SiteMonitor.update!
  end

  it "doesn't create an incident when test failure threshold is not hit" do
    expect_any_instance_of(ContentTest).to receive(:check!) { failed_test }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    incident_count = Incident.active.count
    SiteMonitor.update!
    expect(Incident.active.count).to eq incident_count
  end

  it "creates an incident when test failure threshold hit" do
    Incident.any_instance.stub(:send_alert_email)
    FactoryGirl.create(:test_result, test: @site.tests.first, result: false)
    expect_any_instance_of(ContentTest).to receive(:check!) { FactoryGirl.create(:test_result, test: @site.tests.first, result: false) }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    incident_count = Incident.active.count
    SiteMonitor.update!
    expect(Incident.active.count).to eq (incident_count+1)
  end

  it "doesn't clear an incident when test success threshold not hit" do
    expect_any_instance_of(ContentTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    incident_count = Incident.active.count
    SiteMonitor.update!
    expect(Incident.active.count).to eq incident_count
  end

  it "clears an incident when test success threshold hit" do
    Incident.any_instance.stub(:send_alert_email)
    Incident.any_instance.stub(:send_clear_email)
    incident_test = FactoryGirl.build(:incident_test, test: @site.tests.first)
    incident = FactoryGirl.create(:incident, site: @site, incident_tests: [incident_test])
    incident_test.save
    FactoryGirl.create(:test_result, test: @site.tests.first, result: true)
    expect_any_instance_of(ContentTest).to receive(:check!) { FactoryGirl.create(:test_result, test: @site.tests.first, result: true) }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    incident_count = Incident.active.count
    SiteMonitor.update!
    expect(Incident.active.count).to eq (incident_count-1)
  end

  it "doesn't create an incident if one already exists" do
    Incident.any_instance.stub(:send_alert_email)
    Incident.any_instance.stub(:send_clear_email)
    incident_test = FactoryGirl.build(:incident_test, test: @site.tests.first)
    incident = FactoryGirl.create(:incident, site: @site, incident_tests: [incident_test])
    incident_test.save
    FactoryGirl.create(:test_result, test: @site.tests.first, result: false)
    expect_any_instance_of(ContentTest).to receive(:check!) { FactoryGirl.create(:test_result, test: @site.tests.first, result: false) }
    expect_any_instance_of(ResponseTest).to receive(:check!) { passed_test }
    expect_any_instance_of(ResponseTimeTest).to receive(:check!) { passed_test }
    incident_count = Incident.active.count
    SiteMonitor.update!
    expect(Incident.active.count).to eq incident_count
  end

  private

  def passed_test
    FactoryGirl.build(:test_result, result: true)
  end

  def failed_test
    FactoryGirl.build(:test_result, result: false)
  end

end
