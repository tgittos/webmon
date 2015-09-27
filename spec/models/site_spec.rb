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
