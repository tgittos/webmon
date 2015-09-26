require "rails_helper"

RSpec.feature "Users can list sites" do

  scenario "with the site details" do
    site = FactoryGirl.create(:site, name: "Google Status Page")

    visit "/"
    click_link "Google Status Page"
    expect(page.current_url).to eq site_url(site)
  end
end

