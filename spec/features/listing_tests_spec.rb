require 'rails_helper'

RSpec.feature "Users can view tests" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")
    
    [:content_test, :response_test, :response_time_test].each do |test_type|
      test = FactoryGirl.create(test_type, site: @site) 
      FactoryGirl.create(:test_result, test: test, result: true)
    end
    
    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { uid: @user.app_uid } } 

    visit site_path(@site)
  end

  scenario "with each test's last status" do
    expect(find('#tests')).to have_css('li.ok')
  end

  scenario "and click on the test to visit it" do
    test = ContentTest.last
    click_link test.to_s
    expect(page.current_url).to eq site_content_test_url(@site, test)
  end

end
