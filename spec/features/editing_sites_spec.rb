require 'rails_helper'

RSpec.feature "Users can edit existing sites" do

  before do
    FactoryGirl.create(:site, name: "Google Status Page")

    visit "/"
    click_link "Google Status Page"
    click_link "Edit Site"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "New Google Status Page"
    click_button "Update Site"
    
    expect(page).to have_content "Site has been updated."
    expect(page).to have_content "New Google Status Page"
  end

  scenario "without name" do
    fill_in "Name", with: ""
    fill_in "Url", with: "http://google.com"
    click_button "Update Site"

    expect(page).to have_content "Site has not been updated."
    expect(page).to have_content "Name can't be blank"
  end

  scenario "without name" do
    fill_in "Name", with: "New Google status Page"
    fill_in "Url", with: ""
    click_button "Update Site"

    expect(page).to have_content "Site has not been updated."
    expect(page).to have_content "Url can't be blank"
  end
  
end
