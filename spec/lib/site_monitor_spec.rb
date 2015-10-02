require 'rails_helper'
require 'site_monitor'

describe "site monitor" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")
    5.times do |i|
      FactoryGirl.create(:content_test, site: @site, content: "foobar #{i}")
    end
  end

  it "runs the site check" do
    expect_any_instance_of(Site).to receive(:check!)
    SiteMonitor.update!
  end

  it "runs each of the content_tests" do
    expect_any_instance_of(ContentTest).to receive(:check!)
    SiteMonitor.update!
  end

  it "doesn't check a site that is disabled" do
    @site.active = false
    @site.save
    expect_any_instance_of(Site).to_not receive(:check!)
    SiteMonitor.update!
  end

end
