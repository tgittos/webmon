require "rails_helper"

RSpec.feature "Users can add new sites" do

  before do
    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { uid: @user.app_uid } } 
    visit "/"
    click_link "New Site"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Google Status Page"
    fill_in "Url", with: "http://www.google.com/appsstatus"
    click_button "Create Site"

    expect(page).to have_content "Site has been created."
  end

  scenario "with missing name" do
    fill_in "Url", with: "http://www.google.com/appsstatus"
    click_button "Create Site"

    expect(page).to have_content "Site has not been created."
    expect(page).to have_content "Name can't be blank"
  end
  
  scenario "with missing URL" do
    fill_in "Name", with: "Google Status Page"
    click_button "Create Site"

    expect(page).to have_content "Site has not been created."
    expect(page).to have_content "Url can't be blank"
  end

end

