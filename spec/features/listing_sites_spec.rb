require "rails_helper"

RSpec.feature "Users can add new sites" do
  scenario "with valid attributes" do
    visit "/"

    click_link "New Site"

    fill_in "Name", with: "Google Status Page"
    fill_in "Url", with: "http://www.google.com/appsstatus"
    click_button "Create Site"

    expect(page).to have_content "Site has been created."
  end
end

