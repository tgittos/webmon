require 'rails_helper'

RSpec.describe "user can view test" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")
    @test = FactoryGirl.create(:content_test, site: @site, content: "foobar")
    
    # 9 times, cause creating the initial content test creates a test_status
    9.times do
      FactoryGirl.create(:test_result, test: @test, result: true)
    end
    
    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { uid: @user.app_uid } } 

    visit site_content_test_path(@site, @test)
  end

  scenario "with the site name" do
    expect(page).to have_content @site.name 
  end

  scenario "with the matching criteria" do
    expect(page).to have_content @test.to_s
  end

  scenario "with history of results" do
    expect(find('#results ul')).to have_selector('li', count: 10)
    expect(find('#results')).to have_css('li.ok')
  end

end
