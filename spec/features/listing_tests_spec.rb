require 'rails_helper'

RSpec.feature "Users can view past content tests" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")
    10.times do |n|
      result = FactoryGirl.create(:content_test, site: @site, content: "Foobar #{n}")
      result.test_statuses << FactoryGirl.create(:test_status, content_test: result, result: true)
    end

    visit site_path(@site)
  end

  scenario "up to 10 previous tests" do
    expect(find('#content_tests ul')).to have_selector('li', count: 10) 
  end

  scenario "with each test's last status" do
    expect(find('#content_tests')).to have_css('li.ok')
  end

  scenario "and click on the test to visit it" do
    content_test = ContentTest.last
    click_link content_test.to_s
    expect(page.current_url).to eq site_content_test_url(@site, content_test)
  end

end
