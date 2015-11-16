require 'rails_helper'

RSpec.describe Incident, type: :model do

  before do
    @site = FactoryGirl.create(:site)
    expect(AlertMailer).to receive(:rolled_up_failure) { double("AlertMailer", deliver_now: true) }
  end

  it "filters cleared incidents from active scope" do
    expect(AlertMailer).to receive(:clear) { double("AlertMailer", deliver_now: true) }
    incident = FactoryGirl.create(:incident)
    expect(Incident.active.count).to eq 1
    incident.clear
    expect(Incident.active.count).to eq 0
  end

  it "sends an email when an incident is created" do
    expect_any_instance_of(Incident).to receive(:send_alert_email).and_call_original
    Incident.create site: @site
  end
  
  it "sends a clear email when an incident is cleared" do
    incident = FactoryGirl.create(:incident)
    expect(AlertMailer).to receive(:clear) { double("AlertMailer", deliver_now: true) }
    expect_any_instance_of(Incident).to receive(:send_clear_email).and_call_original
    incident.clear
  end

end
