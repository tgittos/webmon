require "rails_helper"

RSpec.feature "Users can list sites" do

  before do
    @user = FactoryGirl.create(:user)
    @site = FactoryGirl.create(:site, user: @user, name: "Google Status Page")
    FactoryGirl.create(:site, name: "Spiceworks Home Page")
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { auid: @user.app_uid } } 
  end

  scenario "that belong to them" do
    visit "/"
    expect(page).to have_content("Google Status Page")
    expect(page).to_not have_content("Spiceworks Home Page")
  end

  scenario "with the site details" do
    visit "/"
    click_link "Google Status Page"
    
    expect(page.current_url).to eq site_url(@site)
  end

  scenario "with the site's current HTTP status" do
    FactoryGirl.create(:site_health, site: @site, http_response: 200)

    visit "/"
    click_link "Google Status Page"

    expect(page).to have_content "200"
  end

  scenario "with the site's current response time" do
    SiteHealth.destroy_all # shouldn't have to do this?

    FactoryGirl.create(:site_health, site: @site, response_time: 200)

    visit "/"
    click_link "Google Status Page"

    expect(page).to have_content "200ms"
  end
end

