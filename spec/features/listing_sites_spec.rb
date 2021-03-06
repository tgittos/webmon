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

  scenario "with a list of current tests" do
    [:content_test, :response_test, :response_time_test].each do |test_type|
      FactoryGirl.create(test_type, site: @site) 
    end

    visit "/"
    click_link "Google Status Page"

    Test.all.each do |test|
      expect(page).to have_content test.to_s
    end
  end

end

