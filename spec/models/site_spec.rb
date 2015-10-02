require 'rails_helper'

RSpec.describe Site, type: :model do

  it "checks the site after save" do
    site = FactoryGirl.build(:site)
    expect(site).to receive(:check!)
    site.save
  end

  it "creates a valid SiteHealth model when checking the site" do
    mock_time

    site = FactoryGirl.build(:site)
    old_count = SiteHealth.count
    site.save
    expect(SiteHealth.count).to eq (old_count + 1)

    health = SiteHealth.last
    expect(health.http_response).to eq 200
    expect(health.response_time).to eq 1000
  end

  it "latest_status returns ok when last check was 200" do
    site = FactoryGirl.create(:site)
    result = FactoryGirl.create(:site_health, site: site, http_response: 200)
    expect(site.latest_status).to eq "ok"
  end

  it "latest_status returns error when last check was not 200" do
    site = FactoryGirl.create(:site)
    result = FactoryGirl.create(:site_health, site: site, http_response: 500)
    expect(site.latest_status).to eq "error"
  end

  it "latest_status returns warning when content_test fails" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.create(:content_test, site: site)
    result = FactoryGirl.create(:test_status, content_test: content_test, result: false)
    expect(site.latest_status).to eq "warning"
  end

  it "latest_status last check failure takes precedence" do
    site = FactoryGirl.create(:site)
    result = FactoryGirl.create(:site_health, site: site, http_response: 500)
    content_test = FactoryGirl.create(:content_test, site: site)
    content_test_result = FactoryGirl.create(:test_status, content_test: content_test, result: false)
    expect(site.latest_status).to eq "error"
  end

  private

  def mock_time
    now = Time.now
    counter = 0

    # woo closures!
    allow(Time).to receive(:now) {
      counter += 1
      now + counter.seconds
    }
  end

end
