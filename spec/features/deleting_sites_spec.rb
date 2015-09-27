require "rails_helper"

RSpec.feature "Users can delete sites" do
    
  scenario "successfully" do
    FactoryGirl.create(:site, name: "Google Status Page")

    visit "/"
    click_link "Google Status Page"
    click_link "Delete Site"

    expect(page).to have_content "Site has been deleted."
    expect(page.current_url).to eq sites_url
    expect(page).to have_no_content "Google Status Page"
  end

end
