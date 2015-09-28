require 'rails_helper'

RSpec.feature "Users can create content tests" do

  before do
    site = FactoryGirl.create(:site, name: "Google Status Page")

    visit site_path(site)
    click_link "New Test"
  end

  scenario "with valid attributes" do
    select("matches", from: "content_test_comparison")
    fill_in "Content", with: "Foobar"
    click_button "Create Content test"

    expect(page).to have_content "Content test has been created."
  end

  scenario "with invalid attributes" do
    click_button "Create Content test"

    expect(page).to have_content "Content test has not been created."
    expect(page).to have_content "Contentcan't be blank"
  end

end
