require "rails_helper"

RSpec.feature "Users can delete sites" do

  before do
    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { auid: @user.app_uid } } 
  end
    
  scenario "successfully" do
    FactoryGirl.create(:site, user: @user, name: "Google Status Page")

    visit "/"
    click_link "Google Status Page"
    click_link "Delete Site"

    expect(page).to have_content "Site has been deleted."
    expect(page.current_url).to eq sites_url
    expect(page).to have_no_content "Google Status Page"
  end

end
