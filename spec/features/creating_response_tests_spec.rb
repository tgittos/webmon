require 'rails_helper'

RSpec.feature "Users can create response tests" do

  before do
    site = FactoryGirl.create(:site, name: "Google Status Page")

    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { uid: @user.app_uid } } 
    visit site_path(site)
    click_link "New Response Test"
  end

  scenario "with valid attributes" do
    select("equals", from: "response_test_comparison")
    fill_in "Content", with: "Foobar"
    click_button "Create Response test"

    expect(page).to have_content "Response test has been created."
  end

  scenario "with invalid attributes" do
    click_button "Create Response test"

    expect(page).to have_content "Response test has not been created."
    expect(page).to have_content "Contentcan't be blank"
  end

end
